//
//  ErrorHandling.h
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef ErrorHandling_h
#define ErrorHandling_h

typedef void (*debugCallback)(const char* const msg);
extern debugCallback dbgCallback;



#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>

#ifdef IS_DEBUG

#ifndef SHLog
#define SHLog(x) if(dbgCallback) dbgCallback(x);
#endif
#else
#ifndef SHLog
#define SHLog(x)
#endif
#endif

typedef enum {
    NO_ERROR = 0,
    NULL_VALUES = 1,
    OUT_OF_RANGE = 2,
    CORRUPT_STRUCT = 3,
    GEN_ERROR = -1,
    INVALID_STATE = -3
} SHErrorCode;


typedef bool (*ErrorCallback)(SHErrorCode err,const char* const msg,void* info,bool* isError);

typedef struct {
    SHErrorCode code;
    ErrorCallback errorCallback;
    const char* msg;
    void* callbackInfo;
    bool isError;
    uintptr_t filler[8];
} SHError;

bool setErrorCode(SHErrorCode code,SHErrorCode *error);
bool handleError(SHErrorCode code,const char* const msg,SHError* errObj);
int setIndexErrorCode(SHErrorCode code,SHErrorCode* error);
int handleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError* errObj);
void * handleErrorRetNull(SHErrorCode code,const char* const msg,SHError* errObj);
void prepareSHError(SHError* errObj);
void disposeSHError(SHError* errObj);
void setDebugCallback(debugCallback callback);
#endif /* ErrorHandling_h */
