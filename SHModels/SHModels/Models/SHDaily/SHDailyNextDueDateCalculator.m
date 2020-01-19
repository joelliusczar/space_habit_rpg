//
//	SHDailyNextDueDateCalculator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyNextDueDateCalculator.h"
#import "SHWeeklyRateItemList.h"
#import <SHSpecial_C/SHDaily_C.h>
@import SHCommon;

@implementation SHDailyNextDueDateCalculator


-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider){
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}


-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	lastActivationDateTime:(NSDate *)lastActivationDateTime
	lastUpdateDateTime:(NSDate *)lastUpdateDateTime
	dayStartTime:(NSInteger)dayStartTime
{
	if(self = [super init]) {
		_activeDaysContainer = activeDaysContainer;
		_lastActivationDateTime = lastActivationDateTime;
		_lastUpdateDateTime = lastUpdateDateTime;
		_dayStartTime = dayStartTime;
	}
	return self;
}


static void convertObjCRateItemToC(SHWeeklyRateItemList* rateItems, SHRateValueItem *rvi){
	for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
		[rateItems[i] copyIntoCStruct:&rvi[i]];
	}
}


-(NSDate*)nextDueDate_WEEKLY{
	NSDate *lastCheckinDate = self.lastActivationDateTime?
		self.lastActivationDateTime:
		self.lastUpdateDateTime;
	SHDatetime *lastCheckinDt = calloc(1, sizeof(SHDatetime));
	SHDatetime *checkinDt = calloc(1, sizeof(SHDatetime));
	SHDatetime ans;
	memset(&ans,0,sizeof(SHDatetime));
	SHError *error = calloc(1, sizeof(SHError));
	shTryTimestampToDt(lastCheckinDate.timeIntervalSince1970,0,lastCheckinDt,error);
	shTryTimestampToDt(self.dateProvider.date.timeIntervalSince1970,0,checkinDt,error);
	SHRateValueItem *rvi = calloc(SH_DAYS_IN_WEEK, sizeof(SHRateValueItem));
	convertObjCRateItemToC(self.activeDaysContainer.weeklyActiveDays,rvi);
	shNextDueDate_WEEKLY(lastCheckinDt,checkinDt,rvi,
		self.activeDaysContainer.weeklyActiveDays.intervalSize,
		self.dayStartTime, &ans, error);
	double dueDateTimestamp = shDtToTimestamp(&ans, error);
	NSDate *nextDueDate = [NSDate dateWithTimeIntervalSince1970:dueDateTimestamp];
	shFreeSHDatetime(lastCheckinDt,1);
	shFreeSHDatetime(checkinDt,1);
	shDisposeSHError(error);
	shFreeSHRateValueItem(rvi);
	return nextDueDate;
}


@end
