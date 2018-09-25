//
//  ErrorHandling.h
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef ErrorHandling_h
#define ErrorHandling_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>

typedef enum {
    NO_ERROR = 0,
    NULL_VALUES = 1,
    OUT_OF_RANGE = 2,
    CORRUPT_STRUCT = 3
} SHErrorCode;


typedef bool (*ErrorCallback)(SHErrorCode err,const char* const msg,void* info,
  bool* isError);

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
void setSHErrorDefault(SHError* errObj);
void prepareSHError(SHError* errObj);
void disposeSHError(SHError* errObj);
#endif /* ErrorHandling_h */
