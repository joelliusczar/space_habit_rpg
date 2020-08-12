//
//  SHFileOps.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 8/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHFileOps_h
#define SHFileOps_h

#include "SHErrorHandling.h"
#include <stdio.h>

struct SHResourceProvider {
	SHErrorCode (*loadObjectFromFile)(void *, uint64_t, const char *);
	SHErrorCode (*saveObjectToFile)(void *, uint64_t, const char *);
};

extern const struct SHResourceProvider SH_RESOURCE_FN_DEFAULTS;

SHErrorCode SH_loadObjectFromFile(void *data, uint64_t objectSize, const char *path);
SHErrorCode SH_saveObjectToFile(void *data, uint64_t objectSize, const char *path);

#endif /* SHFileOps_h */
