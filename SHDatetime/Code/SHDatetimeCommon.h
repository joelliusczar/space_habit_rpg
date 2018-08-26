//
//  SHDatetimeCommon.h
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetimeCommon_h
#define SHDatetimeCommon_h

#include "SHDatetime_struct.h"
#include <stdbool.h>

typedef enum {NO_OPTION = 0,
    SHIFT_FWD = 1,
    SHIFT_BKD = 2,
    ERROR = 3,
    SIMPLE = 4,
} TimeAdjustOptions;

bool initDt(SHDatetime *dt);

bool initTimeshift(Timeshift *shift);


#endif /* SHDatetimeCommon_h */
