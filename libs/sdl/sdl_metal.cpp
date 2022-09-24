#define HL_NAME(n) sdl_##n
#include "sdl_common.h"
#include <locale.h>

//#define NS_PRIVATE_IMPLEMENTATION
//#define CA_PRIVATE_IMPLEMENTATION
//#define MTL_PRIVATE_IMPLEMENTATION
//#include <Foundation/Foundation.hpp>
//#include <Metal/Metal.hpp>
//#include <QuartzCore/QuartzCore.hpp>

#if defined(_WIN32) || defined(__ANDROID__) || defined(HL_IOS) || defined(HL_TVOS)
#	include <SDL.h>
#	include <SDL_syswm.h>
#elif defined(HL_MAC)
#	include <SDL.h>
#else
#	include <SDL2/SDL.h>
#endif


#ifndef SDL_MAJOR_VERSION
#	error "SDL2 SDK not found in hl/include/sdl/"
#endif


HL_PRIM SDL_MetalView HL_NAME(win_metal_create_view)(SDL_Window *win) {
	return SDL_Metal_CreateView(win);
}

HL_PRIM void * HL_NAME(metal_view_get_layer)(SDL_MetalView mtlview) {
	return SDL_Metal_GetLayer(mtlview);
}


