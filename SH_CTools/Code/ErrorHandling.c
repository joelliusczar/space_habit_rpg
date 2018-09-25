//
//  ErrorHandling.c
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "ErrorHandling.h"
#include "SHConstants.h"
#include <stdlib.h>

static void _useErrorObj(SHErrorCode code,const char* const msg,SHError* errObj){
    if(!errObj) return;
    errObj->code = code;
    errObj->msg = msg;
    errObj->isError = true;
    if(errObj->errorCallback){
        errObj->errorCallback(code,msg,errObj->callbackInfo,&errObj->isError);
    }
}

bool setErrorCode(SHErrorCode code,SHErrorCode *error){
    *error = code;
    return false;
}

bool handleError(SHErrorCode code,const char* const msg,SHError* errObj){
    _useErrorObj(code, msg, errObj);
    return false;
}

int setIndexErrorCode(SHErrorCode code,SHErrorCode *error){
    *error = code;
    return NOT_FOUND;
}

int handleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError *errObj){
    _useErrorObj(code, msg, errObj);
    return NOT_FOUND;
}

void setSHErrorDefault(SHError * errObj){
    if(!errObj) return;
    errObj->code = NO_ERROR;
    errObj->errorCallback = NULL;
    errObj->callbackInfo = NULL;
}

void prepareSHError(SHError* errObj){
    if(!errObj) return;
    errObj->code = NO_ERROR;
    errObj->msg = "";
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
void disposeSHError(SHError *errObj){
	if(!errObj) return;
	free(errObj->msg);
	free(errObj->callbackInfo);
	free(errObj);
}

#pragma GCC diagnostic pop
