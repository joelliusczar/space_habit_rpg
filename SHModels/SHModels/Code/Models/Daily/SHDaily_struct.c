//
//  SHDaily_struct.c
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_struct.h"
#include <stdlib.h>


void SH_freeDailyProps(struct SHDaily *daily) {
	free(daily->base.name);
	free(daily->activeFromDateTime);
	free(daily->activeToDateTime);
	free(daily->activeToDateTime);
	free(daily->lastActivationDateTime);
	free(daily->activeDays.yearIntervalHash);
	free(daily->activeDays.yearSkipIntervalHash);
	free(daily->note);
}


void SH_freeDaily(struct SHDaily *daily) {
	SH_freeDailyProps(daily);
	free(daily);
}
