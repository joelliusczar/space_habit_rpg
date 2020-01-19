//
//	SHTimeZone.h
//	SHCommon
//
//	Created by Joel Pridgen on 4/14/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHTimeZone_h
#define SHTimeZone_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include <SHErrorHandling.h>
#include "SHDatetime_struct.h"



int32_t shFindTimeShiftIdx(SHDatetime *dt);
int32_t shSelectTimeShiftForDt(SHDatetime *dt,SHTimeshift *shifts,int32_t shiftCount);
bool shUpdateTimezoneForShifts(SHDatetime *dt,SHError *error);
int32_t shIsValidTimeShift(SHTimeshift *shift);
#endif /* SHTimeZone_h */
