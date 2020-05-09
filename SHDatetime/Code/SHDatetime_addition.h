//
//  SHDatetime_addition.h
//  SHDatetime
//
//  Created by Joel Pridgen on 5/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDatetime_addition_h
#define SHDatetime_addition_h

#include "SHDatetime_struct.h"
#include "SHErrorHandling.h"
#include <stdio.h>
#include <inttypes.h>

SHErrorCode SH_addYearsToDt(struct SHDatetime *dt, int64_t years, SHTimeAdjustOptions options);

SHErrorCode SH_addMonthsToDt(struct SHDatetime *dt, int64_t months, SHTimeAdjustOptions options);

SHErrorCode SH_addDaysToDt(struct SHDatetime *dt, int64_t days, SHTimeAdjustOptions options);

#endif /* SHDatetime_addition_h */
