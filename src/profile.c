/*
 * Copyright (C)2015-2019 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <execinfo.h>
#include <stdio.h>
#include <stdlib.h>

#include "hl.h"
#if HL_HEADER_DEBUG_VERSION != 0x55
#error "HL header version mismatch"
#endif
#include "hlmodule.h"

#if defined(HL_LINUX) || defined(HL_APPLE) || defined(HL_MAC)
#include <semaphore.h>
#include <signal.h>
#include <sys/syscall.h>
#include <unistd.h>
#endif

#if defined(HL_MAC)

#include <sys/stat.h>
#include <mach/mach.h>
#include <mach/mach_vm.h>
#include <dlfcn.h>
#include <objc/runtime.h>
#include <dispatch/dispatch.h>
#endif

#if defined(__GLIBC__)
#if __GLIBC_PREREQ(2, 30)
// tgkill is present
#else
// int tgkill(pid_t tgid, pid_t tid, int sig)
#define tgkill(tgid, tid, sig) syscall(SYS_tgkill, tgid, tid, sig)
#endif
#endif

#define MAX_STACK_SIZE (8 << 20)
#define MAX_STACK_COUNT 2048

HL_API double hl_sys_time( void );
HL_API void hl_setup_profiler( void *, void * );
int hl_module_capture_stack_range( void *stack_top, void **stack_ptr, void **out, int size );
uchar *hl_module_resolve_symbol_full( void *addr, uchar *out, int *outSize, int **r_debug_addr );

typedef struct _thread_handle thread_handle;
typedef struct _profile_data profile_data;

struct _thread_handle {
	int tid;
#	ifdef HL_WIN_DESKTOP
	HANDLE h;
#elif defined(HL_MAC)
	thread_read_t mach_thread;
#	endif
	hl_thread_info *inf;
	char name[128];
	thread_handle *next;
};

struct _profile_data {
	int currentPos;
	int dataSize;
	unsigned char *data;
	profile_data *next;
};

typedef struct {
	profile_data *r;
	int pos;
} profile_reader;

static struct {
	int sample_count;
	volatile int profiling_pause;
	volatile bool stopLoop;
	volatile bool waitLoop;
	thread_handle *handles;
	thread_handle *olds;
	void **tmpMemory;
	void *stackOut[MAX_STACK_COUNT];
	profile_data *record;
	profile_data *first_record;
} data = {0};

#if defined(HL_LINUX) 
static struct
{
	sem_t msg2;
	sem_t msg3;
	sem_t msg4;
	ucontext_t context;
} shared_context;

static void sigprof_handler(int sig, siginfo_t *info, void *ucontext)
{
	ucontext_t *ctx = ucontext;
	shared_context.context = *ctx;
	sem_post(&shared_context.msg2);
	sem_wait(&shared_context.msg3);
	sem_post(&shared_context.msg4);
}
#endif

#if defined(HL_MAC) 
static struct
{
	dispatch_semaphore_t msg2;
	dispatch_semaphore_t  msg3;
	dispatch_semaphore_t  msg4;
	ucontext_t context;
	int done;

} shared_context;

static void sigprof_handler(int sig, siginfo_t *info, void *ucontext)
{
	ucontext_t *ctx = ucontext;
	shared_context.context = *ctx;
	shared_context.done = 1;
//	printf("SIGNALED\n");
//	fflush(stdout);
	dispatch_semaphore_signal(shared_context.msg2);
	dispatch_semaphore_wait(shared_context.msg3, DISPATCH_TIME_FOREVER);
	dispatch_semaphore_signal(shared_context.msg4);
}
#endif

#define     REG_RAX     1
#define     REG_RBX     2
#define     REG_RCX     3
#define     REG_RDX     4
#define     REG_RDI     5
#define     REG_RSI     6
#define     REG_RBP     7
#define     REG_RSP     8
#define     REG_R8      9
#define     REG_R9      10
#define     REG_R10     11
#define     REG_R11     12
#define     REG_R12     13
#define     REG_R13     14
#define     REG_R14     15
#define     REG_R15     16
#define     REG_RIP     17
#define     REG_RFLAGS  18

static void *get_thread_stackptr( thread_handle *t, void **eip ) {
#ifdef HL_WIN_DESKTOP
	CONTEXT c;
	c.ContextFlags = CONTEXT_CONTROL;
	if( !GetThreadContext(t->h,&c) ) return NULL;
#	ifdef HL_64
	*eip = (void*)c.Rip;
	return (void*)c.Rsp;
#	else
	*eip = (void*)c.Eip;
	return (void*)c.Esp;
#	endif
#elif defined(HL_LINUX)
#	ifdef HL_64
	*eip = (void*)shared_context.context.uc_mcontext.gregs[REG_RIP];
	return (void*)shared_context.context.uc_mcontext.gregs[REG_RSP];
#	else
	*eip = (void*)shared_context.context.uc_mcontext.gregs[REG_EIP];
	return (void*)shared_context.context.uc_mcontext.gregs[REG_ESP];
#	endif
#elif defined(HL_MAC)
#	ifdef HL_64
	if (shared_context.done != 1) {
		return NULL;
	}
	struct __darwin_mcontext64 *mcontext = shared_context.context.uc_mcontext;
	void *ptr = mcontext;

	if (ptr == NULL) {
		 return NULL;
	} else {
		//printf("Shared context was updated! %d %p\n", shared_context.done, mcontext);
		//fflush(stdout);
		*eip = (void*)mcontext->__ss.__rip;
		void *ret = (void*)mcontext->__ss.__rsp;
		return ret;

	}
	return NULL;
//	return ret;

	//*eip = (void*)shared_context.context.uc_mcontext.gregs[REG_RIP];
	//return (void*)shared_context.context.uc_mcontext.gregs[REG_RSP];
	//return HUContext_getStackPointers(t->inf->ucontext, eip);
//	ucontext_t *ptr = (ucontext_t *)(t->inf->ucontext);
//	ptr->uc_mcontext->__ss.__rip;
//	ptr->uc_mcontext->__ss.__rsp;

//	if (ptr != NULL) {
	//}
	//printf("get_thread_stackptr: HL_MAC HL_64 %p : uc_context %p\n", t->inf->ucontext, ptr->uc_mcontext);
	
	//*eip = (void*)((ucontext_t *)(t->inf->ucontext))->uc_mcontext->__ss.__rip;
	//return (void*)((ucontext_t *)(t->inf->ucontext))->uc_mcontext->__ss.__rsp;
#	else
	*eip = uc->uc_mcontext->__ss.__eip;
	return uc->uc_mcontext->__ss.__esp;
#	endif
#else
	return NULL;
#endif
}
static void printThreadInfos(const char *name) {
	hl_threads_info *threads = hl_gc_threads_info();
	int i;
	for(i=0;i<threads->count;i++) {
		printf("Step %s Current thread %d [%d] with stack top %p\n", name, i, threads->threads[i]->thread_id, threads->threads[i]->stack_top); 
	}


}
static void thread_data_init( thread_handle *t ) {
#ifdef HL_WIN
	t->h = OpenThread(THREAD_ALL_ACCESS,FALSE, t->tid);
#elif defined(HL_MAC)
	t->mach_thread = t->inf->mach_thread_id;
#endif
}

static void thread_data_free( thread_handle *t ) {
#ifdef HL_WIN
	CloseHandle(t->h);
#endif
}

static bool pause_thread( thread_handle *t, bool b ) {
#ifdef HL_WIN
	if( b )
		return (int)SuspendThread(t->h) >= 0;
	else {
		ResumeThread(t->h);
		return true;
	}
#elif defined(HL_LINUX) 
	if( b ) {
		tgkill(getpid(), t->tid, SIGPROF);
		return sem_wait(&shared_context.msg2) == 0;
	} else {
		sem_post(&shared_context.msg3);
		return sem_wait(&shared_context.msg4) == 0;
	}
#elif defined(HL_MAC)
	//kern_return_t thread_get_state(thread_read_t target_act, thread_state_flavor_t flavor, thread_state_t old_state, mach_msg_type_number_t *old_stateCnt);
	if( b ) {
		pthread_kill( t->inf->ucontext, SIGPROF);
		return dispatch_semaphore_wait(shared_context.msg2, DISPATCH_TIME_FOREVER) == 0;
		
		/*
		if( thread_suspend(t->inf->mach_thread_id) == KERN_SUCCESS) {
			fflush(stdout);
			return true;
		}
		printf("Failed to suspend thread %d\n", t->inf->mach_thread_id);
		*/
	} else {
		dispatch_semaphore_signal(shared_context.msg3);
		return dispatch_semaphore_wait(shared_context.msg4, DISPATCH_TIME_FOREVER) == 0;

		/*
		if( thread_resume(t->inf->mach_thread_id) == KERN_SUCCESS) {
			return true;
		}
		*/
	}
	return false;
#else
	return false;
#endif
}

static void record_data( void *ptr, int size ) {
	
	profile_data *r = data.record;
	if( !r || r->currentPos + size > r->dataSize ) {
		r = malloc(sizeof(profile_data));
		r->currentPos = 0;
		r->dataSize = 1 << 20;
		r->data = malloc(r->dataSize);
		r->next = NULL;
		if( data.record )
			data.record->next = r;
		else
			data.first_record = r;
		data.record = r;
//		fflush(stdout);
	}
	memcpy(r->data + r->currentPos, ptr, size);
	r->currentPos += size;
}
static void
print_trace (void)
{
  void *array[10];
  char **strings;
  int size, i;

  size = backtrace (array, 10);
  strings = backtrace_symbols (array, size);
  if (strings != NULL)
  {

    printf ("Obtained %d stack frames.\n", size);
    for (i = 0; i < size; i++)
      printf ("%s\n", strings[i]);
  }

  free (strings);
}

static void checkThread(  hl_thread_info *t ) {
	if (t->check1 != 1001001) { printf("check1 failed %x id %d\n)", t->check1, t->thread_id); print_trace(); exit(-1);}
	if (t->check2 != 1001002) { printf("check2 failed %x id %d\n)", t->check2, t->thread_id); print_trace(); exit(-1);}
	if (t->check3 != 1001003) { printf("check3 failed %x id %d\n)", t->check3, t->thread_id); print_trace(); exit(-1);}
	if (t->check4 != 1001004) { printf("check4 failed %x id %d\n)", t->check4, t->thread_id); print_trace(); exit(-1);}
	if (t->check5 != 1001005) { printf("check5 failed %x id %d\n)", t->check5, t->thread_id); print_trace(); exit(-1);}
	if (t->check6 != 1001006) { printf("check6 failed %x id %d\n)", t->check6, t->thread_id); print_trace(); exit(-1);}
	if (t->check7 != 1001007) { printf("check7 failed %x id %d\n)", t->check7, t->thread_id); print_trace(); exit(-1);}
	if (t->check8 != 1001008) { printf("check8 failed %x id %d\n)", t->check8, t->thread_id); print_trace(); exit(-1);}
	if (t->check9 != 1001009) { printf("check9 failed %x id %d\n)", t->check9, t->thread_id); print_trace(); exit(-1);}
	if (t->check10 != 10010010) { printf("check10 failed %x id %d\n)", t->check10, t->thread_id); print_trace(); exit(-1);}
	if (t->check11 != 10010011) { printf("check11 failed %x id %d\n)", t->check11, t->thread_id); print_trace(); exit(-1);}
	if (t->check12 != 10010012) { printf("check12 failed %x id %d\n)", t->check12, t->thread_id); print_trace(); exit(-1);}
	if (t->check13 != 10010013) { printf("check13 failed %x id %d\n)", t->check13, t->thread_id); print_trace(); exit(-1);}
	if (t->check14 != 10010014) { printf("check14 failed %x id %d\n)", t->check14, t->thread_id); print_trace(); exit(-1);}
	if (t->check15 != 10010015) { printf("check15 failed %x id %d\n)", t->check15, t->thread_id); print_trace(); exit(-1);}
	if (t->check16 != 10010016) { printf("check16 failed %x id %d\n)", t->check16, t->thread_id); print_trace(); exit(-1);}
	if (t->check17 != 10010017) { printf("check17 failed %x id %d\n)", t->check17, t->thread_id); print_trace(); exit(-1);}
	if (t->check18 != 10010018) { printf("check18 failed %x id %d\n)", t->check18, t->thread_id); print_trace(); exit(-1);}
}

static void read_thread_data( thread_handle *t, int tidx ) {
	checkThread(t->inf);
	//printf("Reading thread...\n");
//	fflush(stdout);
	shared_context.done = 0;

	if( !pause_thread(t,true) ) {
		return;
	}
	//printf("Getting pointer...\n");
//	fflush(stdout);
	void *eip = NULL;
	void *stack = get_thread_stackptr(t,&eip);
	//if (tidx == 0) printf("tid %d stack pointer %p\n", t->tid, stack);
	shared_context.done = 0;

	if( !stack ) {
		pause_thread(t,false);
		printf("Couldn't get stack pointer\n");
		return;
	}

#if defined(HL_LINUX) || defined(HL_MAC)
	if (t->inf->stack_top == NULL) {
		printf("Stack top is NULL on thread '%s' id:%d '%s' \n", t->name, t->tid, t->inf->thread_name);
		exit(-1);
	}
    int count = hl_module_capture_stack_range(t->inf->stack_top, stack, data.stackOut, MAX_STACK_COUNT);
//	printf("\t\t\tStack count %d\n", count);
    pause_thread(t, false);
	if (count > 0) {
		//printf("Stack count %d\n", count);
	}
#else
	int size = (int)((unsigned char*)t->inf->stack_top - (unsigned char*)stack);
	if( size > MAX_STACK_SIZE-32 ) size = MAX_STACK_SIZE-32;
	memcpy(data.tmpMemory + 2,stack,size);
	pause_thread(t, false);
	data.tmpMemory[0] = eip;
	data.tmpMemory[1] = stack;
	size += sizeof(void*) * 2;

	int count = hl_module_capture_stack_range((char*)data.tmpMemory+size, (void**)data.tmpMemory, data.stackOut, MAX_STACK_COUNT);
#endif
	int eventId = count | 0x80000000;
//	printf("eventId %d count %d\n", eventId, count);
	double time = hl_sys_time();
	hl_threads_info *gc = hl_gc_threads_info();
	if( gc->stopping_world ) eventId |= 0x40000000;
	record_data(&time,sizeof(double));
	record_data(&t->tid,sizeof(int));
	record_data(&eventId,sizeof(int));
	record_data(data.stackOut,sizeof(void*)*count);
	if( *t->inf->thread_name && !*t->name )
		memcpy(t->name, t->inf->thread_name, sizeof(t->name));
}

static void hl_profile_loop( void *_ ) {
	double wait_time = 10. / data.sample_count;
	double next = hl_sys_time();
	data.tmpMemory = malloc(MAX_STACK_SIZE);

	hl_threads_info *threads = hl_gc_threads_info();
	int i;
	for(i=0;i<threads->count;i++) {
		//printf("Current thread %d [%d] with stack top %p\n", i, threads->threads[i]->thread_id, threads->threads[i]->stack_top); 
	}

	while( !data.stopLoop ) {
		double t = hl_sys_time();
		if( t < next || data.profiling_pause ) {
			if( !(t < next) ) next = t;
			data.waitLoop = false;
			continue;
		}
		hl_threads_info *threads = hl_gc_threads_info();
		int i;
		thread_handle *prev = NULL;
		thread_handle *cur = data.handles;
		//printf("Examining %d threads\n", threads->count);
		//fflush(stdout);
		for(i=0;i<threads->count;i++) {
			hl_thread_info *t = threads->threads[i];
			//printf("\tExamining thread %d [%d] with stack top %p invisible %d\n", i, t->thread_id, t->stack_top, t->flags & HL_THREAD_INVISIBLE ? 1 : 0);
			if( t->flags & HL_THREAD_INVISIBLE ) continue;
			checkThread(t);
			if( !cur || cur->tid != t->thread_id ) {
//				printf("\t\tHave we lost a thread?\n");
				// have we lost a thread ?
				thread_handle *h = cur;
				thread_handle *hprev = prev;
				while( h ) {
					if( h->tid == t->thread_id ) {
						// remove from previous queue
						if( hprev ) {
							hprev->next = h->next;
						} else {
							data.handles = h->next;
						}
						// insert at current position
						if( prev ) {
							h->next = prev->next;
							prev->next = h;
						} else {
							h->next = data.handles;
							data.handles = h;
						}
						break;
					}
					hprev = h;
					h = h->next;
				}
				if( !h ) {
					//printf("\t\tAllocating handle\n");
					h = malloc(sizeof(thread_handle));
					memset(h,0,sizeof(thread_handle));
					h->tid = t->thread_id;
					h->inf = t;
					if (t->stack_top == NULL) {
						printf("Stack top of %p is NULL on creation on thread '%s' id:%d '%s' \n", t, h->name, h->tid, h->inf->thread_name);
						exit(-1);
					}
					thread_data_init(h);
					h->next = cur;
					cur = h;
					if( prev == NULL ) data.handles = h; else prev->next = h;
				}
			}
			if( (t->flags & HL_THREAD_PROFILER_PAUSED) == 0 ) {
				//printf("\t\tProfiling thread %d [%d] with stack top %p\n", i, t->thread_id, t->stack_top);
				read_thread_data(cur,i);
			}
			prev = cur;
			cur = cur->next;
		}
		if( prev ) prev->next = NULL; else data.handles = NULL;
		while( cur != NULL ) {
			thread_handle *n;
			thread_data_free(cur);
			n = cur->next;
			if( *cur->name ) {
				cur->next = data.olds;
				data.olds = cur;
			} else
				free(cur);
			cur = n;
		}
		next += wait_time;
	}
	free(data.tmpMemory);
	data.tmpMemory = NULL;
	data.sample_count = 0;
	data.stopLoop = false;

	printf("HASHLINK Profiling stopped\n");
}

static void profile_event( int code, vbyte *data, int dataLen );

void hl_profile_setup( int sample_count ) {
	//printThreadInfos("PA");
#	if defined(HL_THREADS) && (defined(HL_WIN_DESKTOP) || defined(HL_LINUX)|| defined(HL_MAC)) 
	hl_setup_profiler(profile_event,hl_profile_end);
	//printThreadInfos("PB");

	if( data.sample_count ) return;
	if( sample_count < 0 ) {
		// was not started with --profile : pause until we get start event
		data.profiling_pause++;
		printf("Profiling disabled\n");
		return;
	}
	data.sample_count = sample_count;
#	if defined(HL_LINUX) // || defined(HL_MAC)
	sem_init(&shared_context.msg2, 0, 0);
	sem_init(&shared_context.msg3, 0, 0);
	sem_init(&shared_context.msg4, 0, 0);
	struct sigaction action = {0};
	action.sa_sigaction = sigprof_handler;
	action.sa_flags = SA_SIGINFO;
	sigaction(SIGPROF, &action, NULL);
#	endif
#	if defined(HL_MAC)
	shared_context.context.uc_mcontext = NULL;
	shared_context.done = 0;
	shared_context.msg2 = dispatch_semaphore_create(0);
	shared_context.msg3 = dispatch_semaphore_create(0);
	shared_context.msg4 = dispatch_semaphore_create(0);


	struct sigaction action = {0};
	action.sa_sigaction = sigprof_handler;
	action.sa_flags = SA_SIGINFO;
	sigaction(SIGPROF, &action, NULL);
#	endif

	//printThreadInfos("PC");
	printf("Profiling enabled (sample count=%d)\n", sample_count);
	hl_thread_start(hl_profile_loop,NULL,false);
#	endif
	//printThreadInfos("PD");
}

static bool read_profile_data( profile_reader *r, void *ptr, int size ) {
	while( size ) {
		if( r->r == NULL ) return false;
		int bytes = r->r->currentPos - r->pos;
		if( bytes > size ) bytes = size;
		if( ptr ) memcpy(ptr, r->r->data + r->pos, bytes);
		size -= bytes;
		r->pos += bytes;
		if( r->pos == r->r->currentPos ) {
			r->r = r->r->next;
			r->pos = 0;
		}
	}
	return true;
}

static int write_names( thread_handle *h, FILE *f ) {
	int count = 0;
	while( h ) {
		if( *h->name ) {
			if( f ) {
				int len = (int)strlen(h->name);
				fwrite(&h->tid,1,4,f);
				fwrite(&len,1,4,f);
				fwrite(h->name,1,len,f);
			} else
				count++;
		}
		h = h->next;
	}
	return count;
}

static void profile_dump() {
	printf("Tring to dump profile %p\n", data.first_record);

	if( !data.first_record ) return;

	data.profiling_pause++;
//	printf("Writing profiling data...\n");
	fflush(stdout);

	FILE *f = fopen("hlprofile.dump","wb");
	int version = HL_VERSION;
	fwrite("PROF",1,4,f);
	fwrite(&version,1,4,f);
	fwrite(&data.sample_count,1,4,f);
	profile_reader r;
	r.r = data.first_record;
	r.pos = 0;
	int samples = 0;
//	printf("Writing profiling data... with version %x \n", version);
	while( true ) {
		double time;
		int i, tid, eventId;
//		printf('Reading.... \n');
//printf('Reading.... \n');
		if( !read_profile_data(&r,&time, sizeof(double)) ) break;
		read_profile_data(&r,&tid,sizeof(int));
		read_profile_data(&r,&eventId,sizeof(int));
		fwrite(&time,1,8,f);
		fwrite(&tid,1,4,f);
		fwrite(&eventId,1,4,f);
//		printf('Profile data event id %d\n', eventId);

		if( eventId < 0 ) {
			int count = eventId & 0x3FFFFFFF;
			read_profile_data(&r,data.stackOut,sizeof(void*)*count);
			//if (count > 0) printf("Reading %d\n", count);
			//fflush(stdout);

			for(i=0;i<count;i++) {
				uchar outStr[256];
				int outSize = 256;
				int *debug_addr = NULL;
				hl_module_resolve_symbol_full(data.stackOut[i],outStr,&outSize,&debug_addr);
				if( debug_addr == NULL ) {
					int bad = -1;
					fwrite(&bad,1,4,f);
				} else {
					fwrite(debug_addr,1,8,f);
					if( (debug_addr[0] & 0x80000000) == 0 ) {
						debug_addr[0] |= 0x80000000;
						fwrite(&outSize,1,4,f);
						fwrite(outStr,1,outSize*sizeof(uchar),f);
					}
				}
			}
			samples++;
		} else {
			int size;
			read_profile_data(&r,&size, sizeof(int));
			if (size > 0) printf("size %d\n", size);
			fflush(stdout);

			fwrite(&size,1,4,f);
			while( size ) {
				int k = size > MAX_STACK_SIZE ? MAX_STACK_SIZE : size;
				read_profile_data(&r,data.tmpMemory,k);
				fwrite(data.tmpMemory,1,k,f);
				size -= k;
			}
		}
	}
	double tend = -1;
	fwrite(&tend,1,8,f);

	// reset debug_addr flags (allow further dumps)
	r.r = data.first_record;
	r.pos = 0;
	while( true ) {
		int i, eventId;
		if( !read_profile_data(&r,NULL, sizeof(double) + sizeof(int)) ) break;
		read_profile_data(&r,&eventId,sizeof(int));
		if( eventId < 0 ) {
			int count = eventId & 0x3FFFFFFF;
			read_profile_data(&r,data.stackOut,sizeof(void*)*count);
			for(i=0;i<count;i++) {
				int *debug_addr = NULL;
				hl_module_resolve_symbol_full(data.stackOut[i],NULL,NULL,&debug_addr);
				if( debug_addr )
					debug_addr[0] &= 0x7FFFFFFF;
			}
		} else {
			int size;
			read_profile_data(&r,&size,sizeof(int));
			read_profile_data(&r,NULL,size);
		}
	}
	// dump threads names
	int names_count = write_names(data.handles,NULL) + write_names(data.olds,NULL);
	fwrite(&names_count,1,4,f);
	write_names(data.handles,f);
	write_names(data.olds,f);
	// done
	fclose(f);
	printf("%d profile samples saved\n", samples);
	data.profiling_pause--;
}

void hl_profile_end() {
	profile_dump();
	if( !data.sample_count ) return;
	data.stopLoop = true;
	while( data.stopLoop ) {};
}

static void profile_event( int code, vbyte *ptr, int dataLen ) {
	switch( code ) {
	case -1:
		hl_get_thread()->flags |= HL_THREAD_PROFILER_PAUSED;
		break;
	case -2:
		hl_get_thread()->flags &= ~HL_THREAD_PROFILER_PAUSED;
		break;
	case -3:
		data.profiling_pause++;
		data.waitLoop = true;
		while( data.waitLoop ) {}
		profile_data *d = data.first_record;
		while( d ) {
			profile_data *n = d->next;
			free(d->data);
			free(d);
			d = n;
		}
		data.first_record = NULL;
		data.record = NULL;
		data.profiling_pause--;
		break;
	case -4:
		data.profiling_pause++;
		break;
	case -5:
		data.profiling_pause--;
		break;
	case -6:
		profile_dump();
		break;
	case -7:
		{
			uchar *end = NULL;
			hl_profile_setup( ptr ? utoi((uchar*)ptr,&end) : 1000);
		}
		break;
	case -8:
		hl_get_thread()->flags |= HL_THREAD_INVISIBLE;
		break;
	default:
		if( code < 0 ) return;
		if( data.profiling_pause || (code != 0 && (hl_get_thread()->flags & HL_THREAD_PROFILER_PAUSED)) ) return;
		data.profiling_pause++;
		data.waitLoop = true;
		while( data.waitLoop ) {}
		double time = hl_sys_time();
		record_data(&time,sizeof(double));
		record_data(&hl_get_thread()->thread_id,sizeof(int));
		record_data(&code,sizeof(int));
		record_data(&dataLen,sizeof(int));
		record_data(ptr,dataLen);
		data.profiling_pause--;
		break;
	}
}
