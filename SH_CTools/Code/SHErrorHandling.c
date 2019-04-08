//
//  SHErrorHandling.c
//  SH_CTools
//
//  Created by Joel Pridgen on 4/21/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHErrorHandling.h"
#include "SHConstants.h"
#include <stdlib.h>

shDebugCallback shDbgCallback;

static void _useErrorObj(SHErrorCode code,const char* const msg,SHError* errObj){
  shLog("_useErrorObj");
  if(!errObj) return;
  errObj->code = code;
  errObj->msg = msg;
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

int shSetIndexErrorCode(SHErrorCode code,SHErrorCode *error){
  *error = code;
  return NOT_FOUND;
}

int shHandleErrorRetNotFound(SHErrorCode code,const char* const msg,SHError *errObj){
  _useErrorObj(code, msg, errObj);
  return NOT_FOUND;
}

void * shHandleErrorRetNull(SHErrorCode code,const char* const msg,SHError* errObj){
  _useErrorObj(code,msg,errObj);
  return NULL;
}


void shPrepareSHError(SHError* errObj){
  shLog("prepareSHError");
  if(!errObj) return;
  errObj->code = NO_ERROR;
  errObj->msg = "";
  errObj->errorCallback = NULL;
  errObj->callbackInfo = NULL;
  shLog("leaving prepareSHError");
}

#pragma GCC diagnostic push
#if defined(__clang__)
#pragma GCC diagnostic ignored "-Wincompatible-pointer-types-discards-qualifiers"
#elif defined(__GNUC__)
#pragma GCC diagnostic ignored "-Wdiscarded-qualifiers"
#endif
void shDisposeSHError(SHError *errObj){
	if(!errObj) return;
	free(errObj->msg);
	free(errObj->callbackInfo);
	free(errObj);
}

#pragma GCC diagnostic pop


void shSetDebugCallback(shDebugCallback callback){
  shDbgCallback = callback;
  shDbgCallback("setter test");
}
