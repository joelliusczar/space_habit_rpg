//
//  SHDailyActivator.h
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDailyActivator_h
#define SHDailyActivator_h

#include "SHDaily_struct.h"
#include "SHTableChangeActions.h"
#include <SHUtils_C/SHErrorHandling.h>
#include <SHUtils_C/SHSerialQueue.h>
#include <stdio.h>

SHErrorCode SH_daily_activate(struct SHSerialQueue *dbQueue, struct SHTableDaily *tableDaily,
	const struct SHTableChangeActions *tableChangeActions);

#endif /* SHDailyActivator_h */
