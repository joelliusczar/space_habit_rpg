//
//  SHDueDateCalculatorInitializer.c
//  SHModels
//
//  Created by Joel Pridgen on 5/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDueDateCalculatorInitializer.h"
#include <assert.h>

SHErrorCode SH_initSHDueDateFuncHub(struct SHDaily *daily,
	struct SHDueDateFuncHub *hub)
{
	assert(daily);
	assert(hub);
	if(daily->activeDays.intervalType == SH_WEEKLY_INTERVAL) {
	
		return SH_NO_ERROR;
	}
	
	return SH_LOGIC_MISROUTE;
}
