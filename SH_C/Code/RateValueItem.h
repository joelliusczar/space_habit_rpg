//
//  RateValueItem.h
//  SH_C
//
//  Created by Joel Pridgen on 1/27/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef RateValueItem_h
#define RateValueItem_h

#include <inttypes.h>
#include <stdbool.h>

typedef struct {
    bool isDayActive;
    int64_t backrange;
    int64_t forrange;
    uintptr_t filler[4];
} RateValueItem;

#endif /* RateValueItem_h */
