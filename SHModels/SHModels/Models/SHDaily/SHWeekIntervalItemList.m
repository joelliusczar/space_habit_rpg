//
//  SHWeekIntervalItemList.m
//  SHModels
//
//  Created by Joel Pridgen on 12/21/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHWeekIntervalItemList.h"
@import SHSpecial_C;
@import SHCommon;

@interface SHWeekIntervalItemList ()
@end

@implementation SHWeekIntervalItemList
{
	SHWeekIntervalPoint _days[SH_WEEKLEN];
}


-(instancetype)init {
	if(self = [super init]) {
		SHWeekIntervalPoint baseIntervalItem;
		baseIntervalItem.isDayActive = true;
		baseIntervalItem.forrange = 0;
		baseIntervalItem.backrange = 0;
		for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
			_days[idx] = baseIntervalItem;
		}
	}
	return self;
}


-(instancetype)initWithRateItemArray:(NSArray<SHItervalItemDict*>*)rateItemArray
	withWeekStartOffset:(int32_t)dayOffset
{
	if(self = [super init]){
		_weeklyDayStart = dayOffset;
		for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
			SHItervalItemDict *item = rateItemArray[idx];
			_days[idx].isDayActive = item[SH_IS_DAY_ACTIVE_KEY].boolValue;
			_days[idx].forrange = item[SH_FORRANGE_KEY].intValue;
			_days[idx].backrange = item[SH_BACKRANGE_KEY].intValue;
		}
	}
	return self;
}


-(void)setDayOfWeek:(NSUInteger)dayIdx to:(bool)newValue{
	int32_t rate = self.intervalSize;
	int32_t backendIdx = (dayIdx + self.weeklyDayStart) % SH_DAYS_IN_WEEK;
	_days[backendIdx].isDayActive = newValue;
	SH_refreshWeek(_days, rate);
}


-(NSMutableArray<SHItervalItemDict*>*)convertToSaveble {
	NSMutableArray *results = [NSMutableArray arrayWithCapacity:SH_DAYS_IN_WEEK];
	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
		results[idx] = @{
			SH_IS_DAY_ACTIVE_KEY : @(_days[idx].isDayActive),
			SH_FORRANGE_KEY : @(_days[idx].forrange),
			SH_BACKRANGE_KEY : @(_days[idx].backrange)
		};
	}
	return results;
}


-(SHWeekIntervalPoint *)objectAtIndexedSubscript:(NSUInteger)idx {
	int32_t backendIdx = (idx + self.weeklyDayStart) % SH_DAYS_IN_WEEK;
	SHWeekIntervalPoint *intervalItem = &_days[backendIdx];
	return intervalItem;
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
		if(_days[idx].isDayActive) {
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


-(SHWeekIntervalPoint*)copyWeek {
	return _days;
}


@end
