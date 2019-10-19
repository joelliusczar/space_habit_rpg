//
//	ErrorHandling.h
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/21/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHErrorHandling_h
#define SHErrorHandling_h

typedef void (*shDebugCallback)(const char* const msg);
extern shDebugCallback shDbgCallback;



#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>

#ifdef IS_DEBUG

#ifndef shLog
#define shLog(x) if(shDbgCallback) shDbgCallback(x);
#endif
#else
#ifndef shLog
#define shLog(x)
#endif
#endif

typedef enum {
	SH_NO_ERROR = 0,
	SH_NULL_VALUES = 1,
	SH_OUT_OF_RANGE = 2,
	SH_CORRUPT_STRUCT = 3,
	SH_GEN_ERROR = -1,
	SH_INVALID_STATE = -3
} SHErrorCode;


typedef bool (*SHErrorCallback)(SHErrorCode err,const char* const msg,void* info,bool* isError);

typedef struct {
	SHErrorCode code;
	SHErrorCallback errorCallback;
	unsigned long msgLen;
	char* msg;
	void* callbackInfo;
	bool isError;
	uintptr_t filler[8];
} SHError;

bool shSetErrorCode(SHErrorCode code,SHErrorCode *error);
bool shHandleError(SHErrorCode code,const char* const msg,SHError* errObj);
int shSetIndexErrorCode(SHErrorCode code,SHErrorCode* error);
int shHandleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError* errObj);
void * shHandleErrorRetNull(SHErrorCode code,const char* const msg,SHError* errObj);
void shPrepareSHError(SHError* errObj);
void shDisposeSHError(SHError* errObj);
void shSetDebugCallback(shDebugCallback callback);
#endif /* SHErrorHandling_h */
