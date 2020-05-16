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
	context->intervalPoints = malloc(sizeof(struct SHWeekIntervalPointList));
	*context->intervalPoints = [inst.activeDays copyWeek];
	context->savedPrevDate = &inst->_useDate; //pointer syntax because can't pass address of a property
	SH_setUseDateToLastActive(&inst->_useDate, context);
	context->isInverse = inst.isInverse;
}


-(struct SHDatetime *)nextDueDate {
	struct SHDatetime *nextDueDate = malloc(sizeof(struct SHDatetime));
	struct SHDatetime *todaylocal = self.dateProvider.dateSHDt;
	struct SHDueDateWeeklyContext dueDateContext;
	_setupDueDateContext(self, &dueDateContext);
	SHErrorCode status = SH_nextDueDate_WEEKLY(todaylocal, &dueDateContext, nextDueDate);
	free(dueDateContext.intervalPoints);
	SH_freeSHDatetime(todaylocal, 1);
	if(status != SH_NO_ERROR) {
		return NULL;
	}
	return nextDueDate;
}


-(BOOL)isDateActive:(struct SHDatetime *)dateInQuestion {
	bool ans = false;
	struct SHDueDateWeeklyContext dueDateContext;
	_setupDueDateContext(self, &dueDateContext);
	SH_isDateADueDate_WEEKLY(dateInQuestion, &dueDateContext, &ans);
	free(dueDateContext.intervalPoints);
	return ans;
}


-(NSInteger)missedDays {
	struct SHDueDateWeeklyContext dueDateContext;
	_setupDueDateContext(self, &dueDateContext);
	struct SHDatetime *todaylocal = self.dateProvider.dateSHDt;
	int64_t missedDays = SH_NOT_FOUND;
	SHErrorCode status = SH_missedDays(todaylocal, &dueDateContext, &missedDays);
	SH_freeSHDatetime(todaylocal, 1);
	free(dueDateContext.intervalPoints);
	if(status != SH_NO_ERROR) {
		return SH_NOT_FOUND;
	}
	return missedDays;
}

@end
