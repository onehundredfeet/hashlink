#define _XOPEN_SOURCE
#include <semaphore.h>
#include <signal.h>
#include <sys/syscall.h>
#include <ucontext.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void *HUContext_create() {
    ucontext_t *ptr = (ucontext_t *)malloc(sizeof(ucontext_t));
    memset(ptr, 0, sizeof(ucontext_t));
    getcontext(ptr);
    return ptr;
}
 
void HUContext_free(void *context) {
    free((ucontext_t *)context);
}

void dumpRegisters(_STRUCT_X86_THREAD_STATE64 *ss) {

	//printf("Register %s is %p\n", "__rax", (void *)ss->__rax);
	//printf("Register %s is %p\n", "__rbx", (void *)ss->__rbx);
	//printf("Register %s is %p\n", "__rcx", (void *)ss->__rcx);
	//printf("Register %s is %p\n", "__rdx", (void *)ss->__rdx);
	//printf("Register %s is %p\n", "__rdi", (void *)ss->__rdi);
	//printf("Register %s is %p\n", "__rsi", (void *)ss->__rsi);
	//printf("Register %s is %p\n", "__rbp", (void *)ss->__rbp);
	//printf("Register %s is %p\n", "__rsp", (void *)ss->__rsp);
	//printf("Register %s is %p\n", "__r8", (void *)ss->__r8);
	//printf("Register %s is %p\n", "__r9", (void *)ss->__r9);
	//printf("Register %s is %p\n", "__r10", (void *)ss->__r10);
	//printf("Register %s is %p\n", "__r11", (void *)ss->__r11);
	//printf("Register %s is %p\n", "__r12", (void *)ss->__r12);
	//printf("Register %s is %p\n", "__r13", (void *)ss->__r13);
	//printf("Register %s is %p\n", "__r14", (void *)ss->__r14);
	//printf("Register %s is %p\n", "__r15", (void *)ss->__r15);
	//printf("Register %s is %p\n", "__rip", (void *)ss->__rip);
	//printf("Register %s is %p\n", "__rflags", (void *)ss->__rflags);
	//printf("Register %s is %p\n", "__cs", (void *)ss->__cs);
	//printf("Register %s is %p\n", "__fs", (void *)ss->__fs);
	//printf("Register %s is %p\n", "__gs", (void *)ss->__gs);

}
void *HUContext_getStackPointers(void *ptr, void **eip) {
    ucontext_t *context = (ucontext_t *)ptr;

    *eip = (void *)context->uc_mcontext->__ss.__rip;
    void *ret = (void *)context->uc_mcontext->__ss.__rsp;

    dumpRegisters(&context->uc_mcontext->__ss);

    return ret;

/*
    _STRUCT_MCONTEXT *mtx = context->uc_mcontext;
    if (mtx != NULL) {
        _STRUCT_X86_THREAD_STATE64 *stx = &mtx->__ss;
        if (stx != NULL) {
            *eip = (void *)stx->__rip;
            void *ret = (void *)stx->__rsp;
            if (ret == NULL) {
                printf("get_thread_stackptr: stack pointer is NULL\n");
                exit(-1);
            } else {
                //					printf("ret is %p", ret);
                //					exit(-1);
            }
            return ret;
        } else {
            printf("get_thread_stackptr: mtx->__ss NULL\n");
            exit(-1);
        }
    } else {
        printf("get_thread_stackptr:ucontextStorage.uc_mcontext is NULL\n");
        exit(-1);
    }
*/
    //return NULL;
}