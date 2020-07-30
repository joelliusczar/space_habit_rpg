//
//  SHTableDailiesFuncs.c
//  SHModels
//
//  Created by Joel Pridgen on 7/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTableDailiesFuncs.h"


uint32_t SH_tableDailiesGrouper(struct SHTableDaily *tableDaily, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx;
	return tableDaily->dueStatus;
}


int32_t SH_tableDailySortingFn(struct SHTableDaily *tableDaily1, struct SHTableDaily *tableDaily2) {
	if(tableDaily1->customUseOrder != tableDaily2->customUseOrder) {
		return tableDaily2->customUseOrder - tableDaily1->customUseOrder;
	}
	int64_t pkDiff = tableDaily2->pk - tableDaily1->pk;
	if(pkDiff == 0) return 0;
	return pkDiff > 0 ? 1 : -1;
}
