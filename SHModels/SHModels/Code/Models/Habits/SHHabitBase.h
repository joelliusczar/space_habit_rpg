//
//  SHHabitBase.h
//  SHData
//
//  Created by Joel Pridgen on 5/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHHabitBase_h
#define SHHabitBase_h

#include <stdio.h>

struct SHHabitBase {
	int64_t pk;
	char *name;
	double lastUpdated;
	int32_t tzOffsetLastUpdateDateTime;
	uint32_t padding;
};


struct SHTableHabit {
	int64_t pk;
	char *name;
};


void SH_freeHabitBase(struct SHHabitBase *habit);


#endif /* SHHabitBase_h */
