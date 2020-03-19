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


-(void)setDayOfWeek:(NSUInteger)dayIdx to:(BOOL)newValue{
	NSArray<SHWeeklyRateItem*> *weekInfo = self.backend;
	NSInteger rate = self.intervalSize;
	bool activeDays[SH_DAYS_IN_WEEK];
	setActivenessArray(weekInfo,activeDays);
	activeDays[dayIdx] = newValue;
	SHRateValueItem rvi[SH_DAYS_IN_WEEK];
	memset(rvi,0,sizeof(SHRateValueItem) * SH_DAYS_IN_WEEK);
	sh_buildWeek(activeDays,rate,rvi);
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


-(NSArray<NSString*>*)weekKeysBasedOnWeekStart{
	NSArray<NSString*> *days = @[@"SUN",@"MON",@"TUE",@"WED",@"THR",@"FRI",@"SAT"];
	if(self.weeklyDayStart == 0){
		return days;
	}
	NSMutableArray<NSString*> *result = [NSMutableArray arrayWithCapacity:7];
	if(self.weeklyDayStart > 6) return nil;
	for(NSUInteger day = 0; day < 7; day++){
		[result addObject:days[(self.weeklyDayStart + day) % 7]];
	}
	return result;
}


+(NSString *)weekDayKeyToFullName:(NSString*)dayKey {
	if([dayKey isEqualToString:@"SUN"]){
		return @"Sunday";
	}
	if([dayKey isEqualToString:@"MON"]){
		return @"Monday";
	}
	if([dayKey isEqualToString:@"TUE"]){
		return @"Tuesday";
	}
	if([dayKey isEqualToString:@"WED"]){
		return @"Wednesday";
	}
	if([dayKey isEqualToString:@"THR"]){
		return @"Thursday";
	}
	if([dayKey isEqualToString:@"FRI"]){
		return @"Friday";
	}
	if([dayKey isEqualToString:@"SAT"]){
		return @"Saturday";
	}
	return nil;
}


-(NSString*)weekDescription {
	NSArray<NSString *> *dayKeys = self.weekKeysBasedOnWeekStart;
	NSMutableArray<NSString *> *filtered = [NSMutableArray array];
	for(NSUInteger idx = 0; idx < dayKeys.count; idx++) {
		if(self.backend[idx].isDayActive) {
			[filtered addObject:dayKeys[idx]];
		}
	}
	if(filtered.count == 7) return @"Every Day";
	NSString *joined = [filtered componentsJoinedByString:@","];
	return joined;
}


+(NSString*)singularFormatString {
	return @"Every Week";
}


+(NSString*)pluralFormatString {
	return @"Every %ld Weeks";
}


-(NSString*)intervalLabelDescription {
	NSString *desc = [NSString stringWithFormat:@"%@ for\n%@",
		self.intervalDescription,
		self.weekDescription];
	return desc;
}


-(NSString*)debugDescription {
	return self.weekDescription;
}


-(NSUInteger)findPrevActiveDayIdx:(NSUInteger)weekdayIdx {
	NSAssert(weekdayIdx < SH_WEEKLEN, @"idx should fit in a week");
	for(NSInteger idx = weekdayIdx - 1; idx >= 0; idx--) {
		if(self.backend[idx].isDayActive) {
			return idx;
		}
	}
	for(NSInteger idx = SH_WEEKLEN - 1; idx > (NSInteger)weekdayIdx; idx--) {
		if(self.backend[idx].isDayActive) {
			return idx;
		}
	}
	@throw [NSException oddException];
}


-(SHRateValueItem *)convertObjCRateItemToC {
	SHRateValueItem *rvi = calloc(SH_DAYS_IN_WEEK, sizeof(SHRateValueItem));
	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++){
		[self[i] copyIntoCStruct:&rvi[i]];
	}
	return rvi;
}


@end
