//
//	RateValueItem.h
//	SH_C
//
//	Created by Joel Pridgen on 1/27/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef SHRateValueItem_h
#define SHRateValueItem_h

#define shFreeSHRateValueItem(rvi) free(rvi)

#include <inttypes.h>
#include <stdbool.h>

typedef struct SHRateValueItem {
	bool isDayActive;
	int64_t backrange;
	int64_t forrange;
	uintptr_t filler[4];
} SHRateValueItem;


#endif /* SHRateValueItem_h */
