#ifndef __H_U_CONTEXT_H__
#define __H_U_CONTEXT_H__

#pragma once

void *HUContext_create();
void HUContext_free(void *context);
void *HUContext_getStackPointers(void *ptr, void **eip);

#endif