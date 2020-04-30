//
//  SHDefaultDateProvider.m
//  SHCommon
//
//  Created by Joel Pridgen on 10/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDefaultDateProvider.h"

@implementation SHDefaultDateProvider


-(NSDate*)date{
	return NSDate.date;
}


-(NSInteger)localTzOffset {
	return NSTimeZone.defaultTimeZone.secondsFromGMT;
}


-(struct SHDatetime)dateSHDt {
	NSTimeInterval timestamp = NSDate.date.timeIntervalSince1970;
	struct SHDatetime ans;
	SH_timestampToDt(timestamp, (int32_t)self.localTzOffset, &ans);
	return ans;
}

@end
