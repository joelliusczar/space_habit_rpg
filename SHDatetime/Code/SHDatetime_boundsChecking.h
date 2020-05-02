//
//  SHDatetime_boundsChecking.h
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDatetime_boundsChecking_h
#define SHDatetime_boundsChecking_h

#include "SHErrorHandling.h"
#include "SHDatetime_struct.h"
#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>

SHErrorCode SH_isTimestampRangeInvalid(double timestamp, int32_t timezoneOffset);
bool SH_areTimeComponentsValid(struct SHDatetime const *dt);

#endif /* SHDatetime_boundsChecking_h */
