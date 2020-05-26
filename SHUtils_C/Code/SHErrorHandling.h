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
#define SH_notifyOfError(err,msg) printf("Error:\n %s \nat %s: %d\n",msg,__FILE__,__LINE__)
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
	SH_SQLITE3_ERROR = 10,
	SH_THREAD_ERROR = 11,
	SH_EXTERNAL_BLOCK = 12,
} SHErrorCode;


#endif /* SHErrorHandling_h */
