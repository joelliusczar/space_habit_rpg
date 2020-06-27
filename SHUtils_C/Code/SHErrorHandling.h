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
#define SH_notifyOfError(err,msg) printf("Error:%d\n %s \nat %s: %d\n",err,msg,__FILE__,__LINE__)
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
	SH_NULL_VALUES = 1 << 0,
	SH_OUT_OF_RANGE = 1 << 1,
	SH_CORRUPT_STRUCT = 1 << 2,
	SH_GEN_ERROR = 1 << 3,
	SH_INVALID_STATE = 1 << 4,
	SH_ILLEGAL_INPUTS = 1 << 5,
	SH_INPUT_BAD_RESULTS = 1 << 6,
	SH_ALLOC = 1 << 7,
	SH_LOGIC_MISROUTE = 1 << 8,
	SH_SQLITE3_ERROR = 1 << 9,
	SH_THREAD_ERROR = 1 << 10,
	SH_EXTERNAL_BLOCK = 1 << 11,
	SH_ILLEGAL_STATE_CHANGED = 1 << 12,
	SH_PRECONDITIONS_NOT_FULFILLED = 1 << 13,
} SHErrorCode;


#endif /* SHErrorHandling_h */
