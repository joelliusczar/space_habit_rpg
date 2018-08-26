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

typedef enum {
    NO_ERROR = 0,
    NULL_VALUES = 1,
    OUT_OF_RANGE = 2,
    CORRUPT_STRUCT = 3
} SHErrorCode;

typedef bool (*ErrorCallback)(SHErrorCode err,const char* const msg,void* info);

typedef struct {
    SHErrorCode code;
    ErrorCallback errorCallback;
    const char* msg;
    void* callbackInfo;
} SHError;

bool setErrorCode(int code,int *error);
bool handleError(SHErrorCode code,const char* const msg,SHError* errObj);
int setIndexErrorCode(int code,int *error);
int handleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError *errObj);
void setSHErrorDefault(SHError* errObj);
void prepareSHError(SHError* errObj);
#endif /* ErrorHandling_h */
