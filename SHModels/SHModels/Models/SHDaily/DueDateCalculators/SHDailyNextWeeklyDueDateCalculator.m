//
//  SHDailyNextWeeklyDueDateCalculator.m
//  SHModels
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDailyNextWeeklyDueDateCalculator.h"
#import "SHConfig.h"
@import SHCommon;
@import SHSpecial_C;

@implementation SHDailyNextWeeklyDueDateCalculator


@synthesize useDate = _useDate;


-(instancetype)initWithRateItemList:(SHWeekIntervalItemList *)activeDays {
	if(self = [super init]){
		_activeDays = activeDays;
	}
	return self;
}


/*
	The main purpose for this is to have a central place where the useDate
	on the calculator gets set to the proper value because
	in some cases, e.g. when the daily is newly created or the user
	changes the active days, then the stored database value is not quite correct
	and will cause further calculations to be incorrect.
	And while we're at it, we're also setting up the rest of the
	due date context.
*/
static void _setupDueDateContext(SHDailyNextWeeklyDueDateCalculator *inst, struct SHDueDateWeeklyContext *context) {
	context->intervalSize = inst.activeDays.intervalSize;
	context->dayStartHour = inst.dayStartTime;
	context->weekStartOffset = SHConfig.weeklyStartDay;
	SH_setUseDateToLastActive(&inst->_useDate, context);
	context->prevUseDate = &inst->_useDate;
	context->intervalPoints = malloc(sizeof(struct SHWeekIntervalPointList));
	*context->intervalPoints = [inst.activeDays copyWeek];
}


-(struct SHDatetime *)nextDueDate {
	struct SHDatetime *nextDueDate = malloc(sizeof(struct SHDatetime)); //returning pointer so need to be on heap
	struct SHDatetime *today = self.dateProvider.dateSHDt;
	struct SHDueDateWeeklyContext dueDateContext;
	_setupDueDateContext(self, &dueDateContext);
	SH_nextDueDate_WEEKLY(today, &dueDateContext, nextDueDate);
	free(dueDateContext.intervalPoints);
	SH_freeSHDatetime(today, 1);
	return nextDueDate;
}


-(BOOL)isDateActive:(struct SHDatetime *)dt {
	bool ans = false;
	struct SHDatetime *today = self.dateProvider.dateSHDt;
	struct SHDueDateWeeklyContext dueDateContext;
	_setupDueDateContext(self, &dueDateContext);
	SH_isDateADueDate_WEEKLY(today, &dueDateContext, &ans);
	free(dueDateContext.intervalPoints);
	SH_freeSHDatetime(today, 1);
	return ans;
}


@end
