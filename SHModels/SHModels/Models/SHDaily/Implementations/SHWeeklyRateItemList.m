//
//  SHWeeklyRateItemList.m
//  SHModels
//
//  Created by Joel Pridgen on 12/21/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHWeeklyRateItemList.h"
#import <SHSpecial_C/SHDaily_C.h>
@import SHCommon;

@interface SHWeeklyRateItemList ()
@property (strong, nonatomic) NSArray<SHWeeklyRateItem*> *backend;
@end

@implementation SHWeeklyRateItemList

static SHWeeklyRateItem* mapDictToWeekly(id item, NSUInteger idx){
	(void)idx;
	NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
	SHWeeklyRateItem *rateItem = [[SHWeeklyRateItem alloc] init];
	rateItem.isDayActive = dict[SH_IS_DAY_ACTIVE_KEY].boolValue;
	rateItem.forrange = dict[SH_FORRANGE_KEY].integerValue;
	rateItem.backrange = dict[SH_BACKRANGE_KEY].integerValue;
	return rateItem;
}


-(instancetype)init {
	if(self = [super init]) {
		SHWeeklyRateItem *baseRateItem = [[SHWeeklyRateItem alloc] init];
		baseRateItem.isDayActive = YES;
		baseRateItem.forrange = 0;
		baseRateItem.backrange = 0;
		_backend = @[baseRateItem, [baseRateItem copy],[baseRateItem copy],
			[baseRateItem copy],[baseRateItem copy],[baseRateItem copy],[baseRateItem copy]];
	}
	return self;
}


-(instancetype)initWithRateItemArray:(NSArray<SHRateItemDict*>*)rateItemArray {
	if(self = [super init]){
		_backend = [rateItemArray mapItemsTo_f:mapDictToWeekly];
	}
	return self;
}


static void setActivenessArray(NSArray<SHWeeklyRateItem*> *week,bool *activenessArray){
	for(int i = 0;i < SH_DAYS_IN_WEEK;i++){
		if(week){ //default to all days active
			activenessArray[i] = week[i].isDayActive;
			continue;
		}
		activenessArray[i] = YES;
	}
}


static NSMutableArray<SHWeeklyRateItem*>* convertCRateItemToObjC(SHRateValueItem *rvi){
	NSMutableArray *converted = [NSMutableArray array];
	for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
		SHWeeklyRateItem *rateItem = [[SHWeeklyRateItem alloc] init];
		[rateItem copyFromCStruct:&rvi[i]];
		[converted addObject:rateItem];
	}
	return converted;
}


static SHRateItemDict* mapWeeklyToDict(id item,NSUInteger idx){
	(void)idx;
	SHWeeklyRateItem *rateItem = (SHWeeklyRateItem*)item;
	SHRateItemDict *dict = @{
		SH_IS_DAY_ACTIVE_KEY : @(rateItem.isDayActive),
		SH_FORRANGE_KEY : @(rateItem.forrange),
		SH_BACKRANGE_KEY : @(rateItem.backrange)
	};
	return dict;
}


-(void)flipDayOfWeek:(NSUInteger)dayIdx{
	NSArray<SHWeeklyRateItem*> *weekInfo = self.backend;
	NSInteger rate = self.intervalSize;
	bool activeDays[SH_DAYS_IN_WEEK];
	setActivenessArray(weekInfo,activeDays);
	activeDays[dayIdx] = !activeDays[dayIdx];
	SHRateValueItem rvi[SH_DAYS_IN_WEEK];
	memset(rvi,0,sizeof(SHRateValueItem) * SH_DAYS_IN_WEEK);
	shBuildWeek(activeDays,rate,rvi);
	NSMutableArray<SHWeeklyRateItem*>* updWeek = convertCRateItemToObjC(rvi);
	self.backend = updWeek;
}


-(NSMutableArray<SHRateItemDict*>*)convertToSaveble {
	return [self.backend mapItemsTo_f:mapWeeklyToDict];
}


-(SHWeeklyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx {
	SHWeeklyRateItem *rateItem = self.backend[idx];
	return rateItem;
}


-(NSString*)singularFormatString {
	return @"Every week";
}


-(NSString*)pluralFormatString {
	return @"Every %ld weeks";
}

@end
