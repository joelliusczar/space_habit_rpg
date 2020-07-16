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

//struct SHDatetimeProvider {
//	int32_t (*getLocalTzOffset)(void);
//	struct SHDatetime *(*getDate)(void);
//	struct SHDatetime *(*getUserTodayStart)(void);
//};


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

void SH_setupDateProvider(struct SHDatetimeProvider *dateProvider) {
	if(!dateProvider) return;
	dateProvider->getLocalTzOffset = _getLocalTzOffset;
	dateProvider->getDate = _getDate;
	dateProvider->getUserTodayStart = _getUserTodayStart;
}
