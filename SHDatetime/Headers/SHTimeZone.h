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



int32_t SH_findTimeShiftIdx(SHDatetime *dt);
int32_t SH_selectTimeShiftIdxForDt(SHDatetime *dt,SHTimeshift *shifts,int32_t shiftCount);
SHErrorCode SH_UpdateTimezoneForShifts(SHDatetime *dt);
#endif /* SHTimeZone_h */
