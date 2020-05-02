//
//  SHDatetime_setters.h
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDatetime_setters_h
#define SHDatetime_setters_h

#include <stdio.h>
#include <inttypes.h>
#include "SHDatetime_struct.h"

void SH_dtSetTimezoneOffset(struct SHDatetime *dt, int32_t timezoneOffset);

void SH_dtSetMonth(struct SHDatetime *dt, int32_t month);

void SH_dtSetDay(struct SHDatetime *dt, int32_t day);

void SH_dtSetYear(struct SHDatetime *dt, int32_t year);

void SH_dtSetHour(struct SHDatetime *dt, int32_t hour);

void SH_dtSetMinute(struct SHDatetime *dt, int32_t minute);

void SH_dtSetSecond(struct SHDatetime *dt, int32_t second);

void SH_dtSetMilisecond(struct SHDatetime *dt, int32_t milisecond);

#endif /* SHDatetime_setters_h */
