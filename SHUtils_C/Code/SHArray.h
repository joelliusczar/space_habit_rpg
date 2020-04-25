//
//	SHArray.h
//	SHUtils_C
//
//	Created by Joel Pridgen on 4/19/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//



#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include <string.h>
#include "SHUtilConstants.h"

/*
	T1 and T2 should both be types
*/
#define SH_DEF_FIND_IDX(T1, T2, P1, P2, P3) static int64_t SH_findIdx_##T1##_##T2( T1 P3 *arr,int64_t len,\
	bool (*test)( T1 P1,int64_t, T2 P2 ), T2 P2 extra)\
{\
	for(int64_t idx = 0; idx < len;idx++){\
		if(test( &arr[idx],idx,extra)) return idx;\
	}\
	return SH_NOT_FOUND;\
}
#define SH_findIdx(T1,T2) SH_findIdx_##T1##_##T2

#define SH_DEF_FIND_IDX_REV(T1, T2, P1, P2, P3) static int64_t SH_findIdxRev_##T1##_##T2( T1 P3 *arr, \
	int64_t len, bool (*test)( T1 P1,int64_t, T2 P2 ), T2 P2 extra)\
{\
	for(int64_t idx = 0; idx < len;idx++){\
		int64_t revIdx = len - idx -1;\
		if(test( &arr[revIdx],idx,extra)) return revIdx;\
	}\
	return SH_NOT_FOUND;\
}
#define SH_findIdxRev(T1,T2) SH_findIdxRev_##T1##_##T2


