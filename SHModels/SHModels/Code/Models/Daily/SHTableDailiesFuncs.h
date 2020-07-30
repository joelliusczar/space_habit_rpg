//
//  SHTableDailiesFuncs.h
//  SHModels
//
//  Created by Joel Pridgen on 7/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTableDailiesFuncs_h
#define SHTableDailiesFuncs_h

#include "SHDaily_struct.h"
#include <stdio.h>
#include <inttypes.h>


//fnArgs and idx are not used
uint32_t SH_tableDailiesGrouper(struct SHTableDaily *tableDaily, void *fnArgs, uint64_t idx);
int32_t SH_tableDailySortingFn(struct SHTableDaily *tableDaily1, struct SHTableDaily *tableDaily2);

#endif /* SHTableDailiesFuncs_h */
