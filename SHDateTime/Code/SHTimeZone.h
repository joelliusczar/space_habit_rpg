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
#include "SHDatetime_struct.h"
#include "TimeShift_struct.h"



int findTimeShiftIdx(SHDatetime *dt);
int selectTimeShiftForDt(SHDatetime *dt,Timeshift *shifts,int shiftCount);
bool updateTimezoneForShifts(SHDatetime *dt,int *error);
int isValidTimeShift(Timeshift *shift);
#endif /* SHTimeZone_h */
