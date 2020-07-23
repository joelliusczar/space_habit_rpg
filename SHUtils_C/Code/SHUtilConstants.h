//
//	SHConstants.h
//	SHUtils_C
//
//	Created by Joel Pridgen on 10/15/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHUtilConstants_h
#define SHUtilConstants_h

#include <stdio.h>
#include <inttypes.h>

extern const int32_t SH_NOT_FOUND;
extern const int32_t SH_SKIP;
extern const int32_t SH_ALLOC_COUNT;
extern const int32_t SH_NULL_CHAR_OFFSET;

extern const int32_t SH_MAX_INT32_LEN;
extern const int32_t SH_MAX_INT64_LEN;

struct SHNullWrapper {
	void *item;
};

extern const struct SHNullWrapper SH_NULL_WRAPPER_OBJ;

#endif /* SHUtilConstants_h */
