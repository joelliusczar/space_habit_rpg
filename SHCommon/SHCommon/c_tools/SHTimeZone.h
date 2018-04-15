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
#include "SHDatetime_struct.h"
#include "TimeShift_struct.h"



int findTimeShiftIdx(SHDateTime *dt);
int selectTimeShiftForDt(SHDateTime *dt,TimeShift *shifts,int shiftCount);
int updateTimezoneForShifts(SHDateTime *dt);
int isValidTimeShift(TimeShift *shift);
#endif /* SHTimeZone_h */
