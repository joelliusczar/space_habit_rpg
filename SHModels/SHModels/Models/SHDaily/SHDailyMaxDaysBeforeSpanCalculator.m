//
//	SHDailyMaxDaysBeforeSpanCalculator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyMaxDaysBeforeSpanCalculator.h"

@implementation SHDailyMaxDaysBeforeSpanCalculator


-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	rate:(int32_t)rate
{
	if(self = [super init]) {
		_activeDaysContainer = activeDaysContainer;
		_rate = rate;
	}
	return self;
}


-(NSInteger)maxDaysBeforeSpan_WEEKLY{
	return self.rate * 7;
}

@end
