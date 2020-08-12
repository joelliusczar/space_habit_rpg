//
//  SHFileOps.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 8/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHFileOps.h"
#include "SHUtilConstants.h"
#include<sys/stat.h>
#include <fcntl.h>
#include <unistd.h>


const struct SHResourceProvider SH_RESOURCE_FN_DEFAULTS = {
	.loadObjectFromFile = SH_loadObjectFromFile,
	.saveObjectToFile = SH_saveObjectToFile
};


SHErrorCode SH_loadObjectFromFile(void *data, uint64_t objectSize, const char *path) {
	if(!data || !path) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	int32_t fileDescriptor = -1;
	int64_t syscallResult = 0;
	struct stat buf;
	fileDescriptor = open(path, O_RDONLY);
	if(fileDescriptor == -1) {
		status = SH_FILE_ERROR;
		goto fnExit;
	}
	if((syscallResult = fstat(fileDescriptor, &buf)) != 0 || !S_ISREG(buf.st_mode)) {
		status = SH_FILE_ERROR;
		goto cleanup;
	}
	if(((int64_t)objectSize) != buf.st_size) {
		status = SH_FILE_ERROR;
		goto cleanup;
	}
	if((syscallResult = read(fileDescriptor, data, objectSize)) == -1) {
		status = SH_FILE_ERROR;
		goto cleanup;
	}
	
	cleanup:
		close(fileDescriptor);
	fnExit:
		return status;
}

SHErrorCode SH_saveObjectToFile(void *data, uint64_t objectSize, const char *path) {
	if(!data || !path) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	int32_t fileDescriptor = -1;
	int64_t syscallResult = 0;
	fileDescriptor = open(path, O_WRONLY | O_CREAT, 0777);
	if(fileDescriptor == -1) {
		status = SH_FILE_ERROR;
		goto fnExit;
	}
	if((syscallResult = read(fileDescriptor, data, objectSize)) != (int64_t)objectSize) {
		status = SH_FILE_ERROR;
		goto cleanup;
	}
	cleanup:
		close(fileDescriptor);
	fnExit:
		return status;
}
