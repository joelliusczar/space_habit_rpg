//
//  SHTimeZone.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/14/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHTimeZone_h
#define SHTimeZone_h

#include <stdio.h>
#include <stdbool.h>
#include <SHErrorHandling.h>
#include "SHDatetime_struct.h"



int shFindTimeShiftIdx(SHDatetime *dt);
int shSelectTimeShiftForDt(SHDatetime *dt,SHTimeshift *shifts,int shiftCount);
bool shUpdateTimezoneForShifts(SHDatetime *dt,SHErrorCode *error);
bool shUpdateTimezoneForShifts_m(SHDatetime *dt,SHError *error);
int shIsValidTimeShift(SHTimeshift *shift);
#endif /* SHTimeZone_h */
