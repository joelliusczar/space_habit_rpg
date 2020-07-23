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
	if(daily->base.name) free(daily->base.name);
	if(daily->activeFromDateTime) free(daily->activeFromDateTime);
	if(daily->activeToDateTime) free(daily->activeToDateTime);
	if(daily->activeToDateTime) free(daily->activeToDateTime);
	if(daily->lastActivationDateTime) free(daily->lastActivationDateTime);
	if(daily->note) free(daily->note);
}


void SH_freeDaily(struct SHDaily *daily) {
	if(!daily) return;
	SH_freeDailyProps(daily);
	free(daily);
}


void SH_cleanupTableDailyProps(struct SHTableDaily *tableDaily) {
	free(tableDaily->name);
	SH_freeSHDatetime(&tableDaily->savedUseDate);
	SH_freeSHDatetime(&tableDaily->nextDueDate);
}

void SH_cleanupTableDaily(struct SHTableDaily *tableDaily) {
	if(!tableDaily) return;
	SH_cleanupTableDailyProps(tableDaily);
	free(tableDaily);
}
