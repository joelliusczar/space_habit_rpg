//
//  SHDueDateCalculatorInitializer.h
//  SHModels
//
//  Created by Joel Pridgen on 5/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDueDateCalculatorInitializer_h
#define SHDueDateCalculatorInitializer_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include <SHDatetime/SHDatetime_struct.h>
#include "SHErrorHandling.h"
#include "SHDBDueDateConstants.h"
#include "SHDaily_struct.h"

struct SHDueDateFuncHub {
	SHIntervalType intervalType;
	struct SHDatetime * (*nextDueDate)(struct SHDaily *daily);
	bool (*isDateActive)(struct SHDaily *daily, struct SHDatetime*);
	int32_t (*missedDays)(struct SHDaily *daily);
};


SHErrorCode SH_initSHDueDateFuncHub(struct SHDaily *daily,
	struct SHDueDateFuncHub *hub);

#endif /* SHDueDateCalculatorInitializer_h */
