//
//  SHTestDateProvider.m
//  SHTestCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHTestDateProvider.h"
@import SHDatetime;

@implementation SHTestDateProvider

@synthesize dayStartTime = _dayStartTime;

-(NSDate*)date{
	return self.testDate;
}

-(int32_t)localTzOffset {
	return self.testTzOffset;
}


-(struct SHDatetime*)dateSHDt {
	struct SHDatetime *ans = [self.testDate SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, self.localTzOffset);
	return ans;
}


-(struct SHDatetime*)userTodayStart {
	struct SHDatetime *ans = [self.testDate SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, self.localTzOffset);
	SH_dtSetToTimeOfDay(ans, self.dayStartTime);
	return ans;
}

@end
