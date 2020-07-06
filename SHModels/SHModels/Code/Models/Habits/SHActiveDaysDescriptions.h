//
//  SHActiveDaysDescriptions.h
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActiveDaysDescriptions_h
#define SHActiveDaysDescriptions_h

#include "SHActiveDaysValues.h"
#include <stdio.h>
#include <inttypes.h>
#include "SHDBDueDateConstants.h"


char * SH_buildWeekDescription(uint8_t weekHash);
char * SH_buildIntervalLabelDescription_week(uint8_t weekHash, int32_t intervalSize);
char * SH_selectIntervalDescription(struct SHActiveDaysValues *activeDays);
char * (*SH_selectDescriptionBuilderFunc(SHIntervalType intervalType))(int32_t, struct SHActiveDaysValues *);

#endif /* SHActiveDaysDescriptions_h */
