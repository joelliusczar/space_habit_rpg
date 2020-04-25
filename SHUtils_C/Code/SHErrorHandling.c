//
//	SHErrorHandling.c
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/21/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHErrorHandling.h"
#include "SHUtilConstants.h"
#include <stdlib.h>
#include <string.h>
#include "SHGenAlgos.h"

shDebugCallback shDbgCallback;

static void _useErrorObj(SHErrorCode code,const char* const msg,SHError* errObj){
	shLog("_useErrorObj");
	if(!errObj) return;
	errObj->code = code;
	errObj->msg = shStrCopy(msg);
	errObj->msgLen = strlen(msg) + 1;
	errObj->isError = true;
	if(errObj->errorCallback){
		errObj->errorCallback(code,msg,errObj->callbackInfo,&errObj->isError);
	}
	shLog("leaving _useErrorObj");
}

bool shSetErrorCode(SHErrorCode code,SHErrorCode *error){
	*error = code;
	return false;
}

bool shHandleError(SHErrorCode code,const char* const msg,SHError* errObj){
	_useErrorObj(code, msg, errObj);
	return false;
}

int32_t shSetIndexErrorCode(SHErrorCode code,SHErrorCode *error){
	*error = code;
	return SH_NOT_FOUND;
}

int32_t shHandleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError *errObj){
	_useErrorObj(code, msg, errObj);
	return SH_NOT_FOUND;
}

void * shHandleErrorRetNull(SHErrorCode code,const char* const msg,SHError* errObj){
	_useErrorObj(code,msg,errObj);
	return NULL;
}


void shPrepareSHError(SHError* errObj){
	shLog("prepareSHError");
	if(!errObj) return;
	errObj->code = SH_NO_ERROR;
	errObj->msg = NULL;
	errObj->msgLen = 0;
	errObj->errorCallback = NULL;
	errObj->callbackInfo = NULL;
	shLog("leaving prepareSHError");
}


void shDisposeSHError(SHError *errObj){
	if(!errObj) return;
	if(errObj->msg) free((void*)errObj->msg);
	if(errObj->callbackInfo) free(errObj->callbackInfo);
	free(errObj);
}


void shSetDebugCallback(shDebugCallback callback){
	shDbgCallback = callback;
	shDbgCallback("setter test");
}
