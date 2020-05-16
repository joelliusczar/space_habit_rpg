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

#ifndef SH_notifyOfError
#define SH_notifyOfError(err,msg) printf("Error: %s \nat %s: %d",msg,__FILE__,__LINE__)
#endif

#define SH_USE_ERR_BRANCHES 1

#ifdef SH_USE_ERR_BRANCHES

#ifndef SH_branchOnErr
#define SH_branchOnErr(fnCall, label, msg) if((status = fnCall) != SH_NO_ERROR) { \
	printf(msg); \
	goto label; \
}
#endif

#else
#ifndef SH_branchOnErr
#define SH_branchOnErr(fnCall, label, msg)
#endif
#endif

typedef enum {
	SH_NO_ERROR = 0,
	SH_NULL_VALUES = 1,
	SH_OUT_OF_RANGE = 2,
	SH_CORRUPT_STRUCT = 3,
	SH_GEN_ERROR = 4,
	SH_INVALID_STATE = 5,
	SH_ILLEGAL_INPUTS = 6,
	SH_INPUT_BAD_RESULTS = 7,
	SH_ALLOC = 8,
	SH_LOGIC_MISROUTE = 9,
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
int32_t shSetIndexErrorCode(SHErrorCode code,SHErrorCode* error);
int32_t shHandleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError* errObj);
void * shHandleErrorRetNull(SHErrorCode code,const char* const msg,SHError* errObj);
void shPrepareSHError(SHError* errObj);
void shDisposeSHError(SHError* errObj);
void shSetDebugCallback(shDebugCallback callback);
#endif /* SHErrorHandling_h */
