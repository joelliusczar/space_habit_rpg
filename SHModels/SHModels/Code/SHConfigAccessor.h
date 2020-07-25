//
//  SHConfigAccessor.h
//  SHModels
//
//  Created by Joel Pridgen on 5/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHConfigAccessor_h
#define SHConfigAccessor_h

#include "SHDBDueDateConstants.h"
#include <stdio.h>
#include <inttypes.h>
#include <SHDatetime/SHDatetime.h>

struct SHConfigAccessor {
	int32_t (*getDayStartHour)(void);
	void (*setDayStartTime)(int32_t);
	int32_t (*getWeekStartOffset)(void);
	void (*setWeekStartOffset)(int32_t);
	SHGameState (*getGameState)(void);
	void (*setGameState)(SHGameState);
	SHStoryMode (*getStoryMode)(void);
	void (*setStoryMode)(SHStoryMode);
	SHStoryState (*getStoryState)(void);
	void (*setStoryState)(SHStoryState);
	struct SHDatetime *(*getLastProcessingDateTime)(void);
	void (*setLastProcessingDateTime)(struct SHDatetime *);
	bool (*getIsAppInitialized)(void);
	void (*setIsAppInitialized)(bool);
};

#endif /* SHConfigAccessor_h */
