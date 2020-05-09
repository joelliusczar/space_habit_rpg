//
//  SHDefaultDateProvider.m
//  SHCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDefaultDateProvider.h"
#import "NSDate+DateHelper.h"

@implementation SHDefaultDateProvider


@synthesize dayStartTime = _dayStartTime;

-(void)setDayStartTime:(int32_t)dayStartTime {
	assert(dayStartTime >= 0 && dayStartTime < SH_DAY_IN_SECONDS);
	_dayStartTime = dayStartTime;
}

-(NSDate*)date{
	return NSDate.date;
}


-(int32_t)localTzOffset {
	return (int32_t)NSTimeZone.defaultTimeZone.secondsFromGMT;
}


-(struct SHDatetime*)dateSHDt {
	struct SHDatetime *ans = [NSDate.date SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, self.localTzOffset);
	return ans;
}


-(struct SHDatetime*)userTodayStart {
	struct SHDatetime *ans = [NSDate.date SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, self.localTzOffset);
	SH_dtSetToTimeOfDay(ans, self.dayStartTime);
	return ans;
}


@end
