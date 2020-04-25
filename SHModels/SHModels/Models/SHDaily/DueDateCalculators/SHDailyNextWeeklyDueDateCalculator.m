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


-(instancetype)initWithRateItemList:(SHWeekIntervalItemList *)activeDays {
	if(self = [super init]){
		_activeDays = activeDays;
	}
	return self;
}


-(SHDatetime *)nextDueDate {
	SHDatetime *nextDueDate = malloc(sizeof(SHDatetime));
	SHDatetime today = self.dateProvider.dateSHDt;
	SHDailyWeeklyDueDateInput inputs;
	inputs.useDate = &today;
	inputs.prevUseDate = self.useDate;
	inputs.intervalPoints = 0;
	inputs.intervalSize = self.activeDays.intervalSize;
	inputs.dayStartHour = self.dayStartTime;
	inputs.weekStartOffset = SHConfig.weeklyStartDay;
	return nil;
}


@end
