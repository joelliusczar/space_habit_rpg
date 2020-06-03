//
//  SHDueDateWeeklyContext_struct.h
//  SHSpecial_C
//
//  Created by Joel Pridgen on 4/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDueDateWeeklyContext_struct_h
#define SHDueDateWeeklyContext_struct_h

#include "SHDatetime_struct.h"
#include "SHWeekIntervalPoint_struct.h"
#include <stdbool.h>

struct SHDueDateWeeklyContext {
	struct SHDatetime *savedPrevDate;
	struct SHWeekIntervalPointList *intervalPoints;
	int32_t intervalSize;
	int32_t dayStartHour;
	int32_t weekStartOffset;
};


#endif /* SHDueDateWeeklyContext_struct_h */
