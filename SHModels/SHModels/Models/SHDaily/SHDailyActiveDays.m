//
//	SHDailyActiveDays.m
//	SHModels
//
//	Created by Joel Pridgen on 5/16/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActiveDays.h"
#import "SHMonthlyYearlyRateItem.h"
#import "SHRateTypeHelper.h"
#import "SHModelConstants.h"
#import "SHConfig.h"
@import SHCommon;
@import SHSpecial_C;


@interface SHDailyActiveDays ()
@property (strong,nonatomic) NSString *jsonRepresentation;
@end

@implementation SHDailyActiveDays


-(instancetype)init {
	self = [self initWithActiveDaysJson:SH_ALL_DAYS_JSON];
	return self;
}

-(instancetype)initWithActiveDaysJson:(NSString*)activeDaysJson{
	if(self = [super init]){
		_jsonRepresentation = activeDaysJson;
	}
	return self;
}


-(NSString*)jsonRepresentation{
	if(nil == _jsonRepresentation){
		_jsonRepresentation = [_activeDaysDict dictToString];
	}
	return _jsonRepresentation;
}


-(NSMutableDictionary*)activeDaysDict{
	if(nil == _activeDaysDict){
		NSString *str = _jsonRepresentation.length > 0 ? _jsonRepresentation : SH_ALL_DAYS_JSON;
		_activeDaysDict = [NSDictionary jsonStringToDict:str];
		if(nil == _activeDaysDict) {
			_activeDaysDict = [NSDictionary jsonStringToDict:SH_ALL_DAYS_JSON];
		}
	}
	return _activeDaysDict;
}


-(NSString*)activeDaysAsJson{
	
	if(nil == _activeDaysDict) {
		return self.jsonRepresentation;
	}
	NSDictionary *dict = [self buildDict];
	NSString *json = [dict dictToString];
	self.activeDaysDict = nil;
	self.jsonRepresentation = json;
	return json;
}


-(SHDailyRateItem*)buildDailyRateItem:(BOOL)isInverse {
	SHDailyRateItem *rateItem = [[SHDailyRateItem alloc] init];
	SHIntervalType dailyRate = isInverse ? SH_DAILY_INTERVAL_INVERSE : SH_DAILY_INTERVAL;
	rateItem.intervalSize = ((NSNumber *)self.activeDaysDict[shGetRateTypeIntervalSizeKey(dailyRate)]).intValue;
	return rateItem;
}


-(SHWeekIntervalItemList*)buildWeeklyActiveDays:(BOOL)isInverse{
	SHIntervalType rateType = isInverse? SH_WEEKLY_INTERVAL_INVERSE : SH_WEEKLY_INTERVAL;
	NSMutableArray<SHItervalItemDict*> *raw = (NSMutableArray*)self.activeDaysDict[shGetRateTypeKey(rateType)];
	SHWeekIntervalItemList *rateItems = nil;
	if(raw.count == 0){
		rateItems = [[SHWeekIntervalItemList alloc] init];
	}
	else {
		rateItems = [[SHWeekIntervalItemList alloc] initWithRateItemArray:raw withWeekStartOffset: SHConfig.weeklyStartDay];
	}
	rateItems.intervalSize = ((NSNumber *)self.activeDaysDict[shGetRateTypeIntervalSizeKey(SH_WEEKLY_INTERVAL)]).intValue;
	return rateItems;
}


-(SHMonthlyYearlyRateItemList*)buildActiveDays:(SHIntervalType)rateType{
	SHIntervalType baseRateType = shExtractBaseRateType(rateType);
	NSMutableArray *raw = (NSMutableArray*)self.activeDaysDict[shGetRateTypeKey(rateType)];
	Class rateClass = baseRateType == SH_MONTHLY_INTERVAL ?
		SHMonthlyRateItemList.class : SHYearlyRateItemList.class;
	SHMonthlyYearlyRateItemList *rateItems = [[rateClass alloc] initWithActiveDays:raw];
	rateItems.intervalSize = ((NSNumber *)self.activeDaysDict[shGetRateTypeIntervalSizeKey(rateType)]).intValue;
	return rateItems;
}


@synthesize monthlyActiveDays = _monthlyActiveDays;
-(SHMonthlyYearlyRateItemList*)monthlyActiveDays{
	if(nil == _monthlyActiveDays){
		_monthlyActiveDays = [self buildActiveDays:SH_MONTHLY_INTERVAL];
	}
	return _monthlyActiveDays;
}


@synthesize monthlyActiveDaysInv = _monthlyActiveDaysInv;
-(SHMonthlyYearlyRateItemList*)monthlyActiveDaysInv{
	if(nil == _monthlyActiveDaysInv){
		_monthlyActiveDaysInv = [self buildActiveDays:SH_MONTHLY_INTERVAL_INVERSE];
	}
	return _monthlyActiveDaysInv;
}


@synthesize yearlyActiveDays = _yearlyActiveDays;
-(SHMonthlyYearlyRateItemList*)yearlyActiveDays{
	if(nil == _yearlyActiveDays){
		_yearlyActiveDays = [self buildActiveDays:SH_YEARLY_INTERVAL];
	}
	return _yearlyActiveDays;
}


@synthesize yearlyActiveDaysInv = _yearlyActiveDaysInv;
-(SHMonthlyYearlyRateItemList*)yearlyActiveDaysInv{
	if(nil == _yearlyActiveDaysInv){
		_yearlyActiveDaysInv = [self buildActiveDays:SH_YEARLY_INTERVAL_INVERSE];
	}
	return _yearlyActiveDaysInv;
}


@synthesize weeklyActiveDays = _weeklyActiveDays;
-(SHWeekIntervalItemList*)weeklyActiveDays{
	if(nil == _weeklyActiveDays){
		_weeklyActiveDays = [self buildWeeklyActiveDays:NO];
	}
	return _weeklyActiveDays;
}


@synthesize weeklyActiveDaysInv = _weeklyActiveDaysInv;
-(SHWeekIntervalItemList*)weeklyActiveDaysInv{
	if(nil == _weeklyActiveDaysInv){
		_weeklyActiveDaysInv = [self buildWeeklyActiveDays:YES];
	}
	return _weeklyActiveDaysInv;
}


@synthesize dailyRateItem = _dailyRateItem;
-(SHDailyRateItem *)dailyRateItem {
	if(nil == _dailyRateItem) {
		_dailyRateItem = [self buildDailyRateItem:NO];
	}
	return _dailyRateItem;
}


@synthesize dailyRateItemInv = _dailyRateItemInv;
-(SHDailyRateItem*)dailyRateItemInv {
	if(nil == _dailyRateItemInv) {
		_dailyRateItemInv = [self buildDailyRateItem:YES];
	}
	return _dailyRateItemInv;
}


-(NSMutableDictionary*)buildDict{
	//using the direct instance variables and checking for null
	//because if I've not changed a sub section, I don't want to
	//map it to an object just to remap it back to a dictionary
	NSMutableArray<SHItervalItemDict*>* weekly = _weeklyActiveDays ?
		[_weeklyActiveDays convertToSaveble] :
		self.activeDaysDict[shGetRateTypeKey(SH_WEEKLY_INTERVAL)];
	NSMutableArray<SHItervalItemDict*>* monthly = _monthlyActiveDays ?
		[_monthlyActiveDays convertToSaveble] :
		self.activeDaysDict[shGetRateTypeKey(SH_MONTHLY_INTERVAL)];
	NSMutableArray<SHItervalItemDict*>* yearly = _yearlyActiveDays ?
		[_yearlyActiveDays convertToSaveble] :
		self.activeDaysDict[shGetRateTypeKey(SH_YEARLY_INTERVAL)];
	
	NSMutableArray<SHItervalItemDict*>* weeklyInv = _weeklyActiveDaysInv ?
		[_weeklyActiveDaysInv convertToSaveble]:
		self.activeDaysDict[shGetRateTypeKey(SH_WEEKLY_INTERVAL_INVERSE)];
	NSMutableArray<SHItervalItemDict*>* monthlyInv = _monthlyActiveDaysInv ?
		[_monthlyActiveDaysInv convertToSaveble] :
		self.activeDaysDict[shGetRateTypeKey(SH_MONTHLY_INTERVAL_INVERSE)];
	NSMutableArray<SHItervalItemDict*>* yearlyInv = _yearlyActiveDaysInv ?
		[_yearlyActiveDaysInv convertToSaveble] :
		self.activeDaysDict[shGetRateTypeKey(SH_YEARLY_INTERVAL_INVERSE)];
	
	NSMutableDictionary *dict = [NSMutableDictionary
		dictionaryWithObjects:@[
			weekly,monthly,yearly, //0,1,2
			weeklyInv,monthlyInv,yearlyInv, //3,4,5
			@(self.dailyRateItem.intervalSize), //6
			@(self.weeklyActiveDays.intervalSize), //7
			@(self.monthlyActiveDays.intervalSize), //8
			@(self.yearlyActiveDays.intervalSize), //9
			@(self.dailyRateItemInv.intervalSize), //10
			@(self.weeklyActiveDaysInv.intervalSize), //11
			@(self.monthlyActiveDaysInv.intervalSize), //12
			@(self.yearlyActiveDaysInv.intervalSize), //13
		]
		forKeys:shRateTypeEnums()];
		
		return dict;
}


-(SHIntervalItemFormat *)selectRateItemCollection:(SHIntervalType)rateType {
	switch (rateType) {
		case SH_DAILY_INTERVAL:
			return self.dailyRateItem;
		case SH_WEEKLY_INTERVAL:
			return self.weeklyActiveDays;
		case SH_MONTHLY_INTERVAL:
			return self.monthlyActiveDays;
		case SH_YEARLY_INTERVAL:
			return self.yearlyActiveDays;
		case SH_DAILY_INTERVAL_INVERSE:
			return self.dailyRateItemInv;
		case SH_WEEKLY_INTERVAL_INVERSE:
			return self.weeklyActiveDaysInv;
		case SH_MONTHLY_INTERVAL_INVERSE:
			return self.monthlyActiveDaysInv;
		case SH_YEARLY_INTERVAL_INVERSE:
			return self.yearlyActiveDaysInv;
		default:
			return nil;
	}
}


@end
