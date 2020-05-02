//
//  SHDayCounts.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDayCounts.h"

const int32_t SH_monthSums[SH_MONTHCOUNT] = {0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334};
const int32_t SH_backwardMonthSums[SH_MONTHCOUNT] = {334, 306, 275, 245, 214, 184, 153, 122, 92, 61, 31, 0};
const int32_t SH_monthCount[SH_MONTHCOUNT] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
