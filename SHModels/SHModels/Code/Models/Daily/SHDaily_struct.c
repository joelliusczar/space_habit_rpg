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
	if(NULL == daily) return;
	free(daily->base.name);
	free(daily->activeFromDateTime);
	free(daily->activeToDateTime);
	free(daily->activeToDateTime);
	free(daily->note);
}


void SH_freeDaily(struct SHDaily *daily) {
	if(!daily) return;
	SH_freeDailyProps(daily);
	free(daily);
}


void SH_cleanupTableDailyProps(struct SHTableDaily *tableDaily) {
	free(tableDaily->name);
	SH_freeSHDatetime(tableDaily->savedUseDate);
	SH_freeSHDatetime(tableDaily->nextDueDate);
	SH_freeSHDatetime(tableDaily->stepLastActivationDateTime);
}

void SH_cleanupTableDaily(struct SHTableDaily *tableDaily) {
	if(!tableDaily) return;
	SH_cleanupTableDailyProps(tableDaily);
	free(tableDaily);
}
