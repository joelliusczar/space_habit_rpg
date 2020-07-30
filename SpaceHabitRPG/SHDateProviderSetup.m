//
//  SHDateProviderSetup.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDateProviderSetup.h"

@import Foundation;
@import SHCommon;


static int32_t _getLocalTzOffset() {
	return (int32_t)NSTimeZone.defaultTimeZone.secondsFromGMT;
}


static struct SHDatetime *_getDate() {
	struct SHDatetime *ans = [NSDate.date SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, _getLocalTzOffset());
	return ans;
}


static struct SHDatetime *_getUserTodayStart() {
	int32_t dayStartTime = (int32_t)[NSUserDefaults.standardUserDefaults integerForKey:@"dayStartTime"];
	struct SHDatetime *ans = [NSDate.date SH_toSHDatetime];
	SH_dtSetTimezoneOffset(ans, _getLocalTzOffset());
	SH_dtSetToTimeOfDay(ans, dayStartTime);
	return ans;
}


const struct SHDatetimeProvider SH_APP_DATETIME_PROVIDER_FUNCS = {
	.getLocalTzOffset = _getLocalTzOffset,
	.getDate = _getDate,
	.getUserTodayStart = _getUserTodayStart
};
