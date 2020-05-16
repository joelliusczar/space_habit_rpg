//
//  SHDateCompare.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/4/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDateCompare.h"
#include "SHDatetimeFuncs.h"

SHErrorCode SH_areDatesEqual(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans) {
	double timestampA = 0;
	double timestampB = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(A, &timestampA)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(B, &timestampB)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampA == timestampB;
	
	fnExit:
		return status;
}


SHErrorCode SH_isDateAGTDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans){
	double timestampA = 0;
	double timestampB = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(A, &timestampA)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(B, &timestampB)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampA > timestampB;
	fnExit:
		return status;
}


SHErrorCode SH_isDateAGTEDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans){
	double timestampA = 0;
	double timestampB = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(A, &timestampA)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(B, &timestampB)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampA >= timestampB;
	fnExit:
		return status;
}


SHErrorCode SH_isDateALTDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans){
	double timestampA = 0;
	double timestampB = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(A, &timestampA)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(B, &timestampB)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampA < timestampB;
	fnExit:
		return status;
}


SHErrorCode SH_isDateALTEDateB(struct SHDatetime * const A, struct SHDatetime * const B, bool *ans){
	double timestampA = 0;
	double timestampB = -1;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(A, &timestampA)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = SH_dtToTimestamp(B, &timestampB)) != SH_NO_ERROR) {
		goto fnExit;
	}
	*ans = timestampA <= timestampB;
	fnExit:
		return status;
}
