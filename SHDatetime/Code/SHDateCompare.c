//
//  SHDateCompare.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/4/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDateCompare.h"
#include "SHDatetimeFuncs.h"

SHErrorCode SH_areDatesEqual(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans) {
	double timestampX = 0;
	double timestampY = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(X, &timestampX)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(Y, &timestampY)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampX == timestampY;
	
	fnExit:
		return status;
}


SHErrorCode SH_isDateXAfterDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans){
	double timestampX = 0;
	double timestampY = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(X, &timestampX)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(Y, &timestampY)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampX > timestampY;
	fnExit:
		return status;
}


SHErrorCode SH_isDateXAfterOrSameAsDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans){
	double timestampX = 0;
	double timestampY = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(X, &timestampX)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(Y, &timestampY)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampX >= timestampY;
	fnExit:
		return status;
}


SHErrorCode SH_isDateXBeforeDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans){
	double timestampX = 0;
	double timestampY = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(X, &timestampX)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(Y, &timestampY)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampX < timestampY;
	fnExit:
		return status;
}


SHErrorCode SH_isDateXBeforeOrSameAsDateY(struct SHDatetime * const X, struct SHDatetime * const Y, bool *ans){
	double timestampX = 0;
	double timestampY = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(X, &timestampX)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(Y, &timestampY)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampX <= timestampY;
	fnExit:
		return status;
}
