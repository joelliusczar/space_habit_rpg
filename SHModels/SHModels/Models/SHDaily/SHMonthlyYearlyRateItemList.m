//
//	SHMonthlyYearlyRateItemList.m
//	SHModels
//
//	Created by Joel Pridgen on 5/5/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonthlyYearlyRateItemList.h"
#import "SHRateTypeHelper.h"

@interface SHMonthlyYearlyRateItemList ()
@property (strong,nonatomic) NSMutableArray<SHMonthlyYearlyRateItem*> *backend;
@end

@implementation SHMonthlyYearlyRateItemList

static void validateRateType(SHRateType rateType) {
	SHRateType baseRateType = shExtractBaseRateType(rateType);
	if(baseRateType != SH_MONTHLY_RATE && baseRateType != SH_YEARLY_RATE) {
		@throw [NSException oddException];
	}
}

@synthesize rateType = _rateType;
-(SHRateType)rateType {
	return _rateType;
}


-(void)setRateType:(SHRateType)rateType {
	validateRateType(rateType);
	_rateType = rateType;
}


static SHMonthlyYearlyRateItem* mapDictToMonthlyYearly(id item, NSUInteger idx){
	(void)idx;
	NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
	NSInteger major = dict[SH_MAJOR_ORDINAL].integerValue;
	NSInteger minor = dict[SH_MINOR_ORDINAL].integerValue;
	SHMonthlyYearlyRateItem *rateItem = [[SHMonthlyYearlyRateItem alloc]
		initWithMajorOrdinal:major
		minorOrdinal:minor];

	return rateItem;
}


-(instancetype)initWithActiveDays:(NSMutableArray<SHRateItemDict*>*)activeDays{
	if(self = [super init]){
		_backend = [activeDays mapItemsTo_f:mapDictToMonthlyYearly];;
	}
	return self;
}


-(NSUInteger)count{
	return self.backend.count;
}


-(NSUInteger)addRateItem:(SHMonthlyYearlyRateItem*)rateItem{
	if(self.touchCallback) self.touchCallback();
	NSUInteger idx = [self.backend findPlaceFor:rateItem
		whereFirstFits:^BOOL(SHMonthlyYearlyRateItem *a,SHMonthlyYearlyRateItem *b){
			BOOL minorCriteria = a.majorOrdinal == b.majorOrdinal && a.minorOrdinal >= b.minorOrdinal;
			return a.majorOrdinal > b.majorOrdinal || minorCriteria;
		}];
	if(idx == self.backend.count){
		[self.backend addObject:rateItem];
		return idx;
	}
	if(![rateItem isEqual: self.backend[idx]]){
		[self.backend insertObject:rateItem atIndex:idx];
		return idx;
	}
	return -1;
}


-(void)removeRateItemAtIndex:(NSUInteger)index{
	if(self.touchCallback){
		self.touchCallback();
	}
	[self.backend removeObjectAtIndex:index];
}


-(SHMonthlyYearlyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx{
	SHMonthlyYearlyRateItem *rateItem = self.backend[idx];
	rateItem.touchCallback = self.touchCallback;
	return rateItem;
}


static NSDictionary* mapMonthlyYearlyToDict(id item,NSUInteger idx){
	(void)idx;
	SHMonthlyYearlyRateItem *rateItem = (SHMonthlyYearlyRateItem*)item;
	SHRateItemDict *dict = @{
		SH_MAJOR_ORDINAL : @(rateItem.majorOrdinal),
		SH_MINOR_ORDINAL : @(rateItem.minorOrdinal)
	};
	return dict;
}


-(NSMutableArray<SHRateItemDict*>*)convertToSaveble {
	return [self.backend mapItemsTo_f:mapMonthlyYearlyToDict];
}


-(NSString*)singularFormatString {
	validateRateType(self.rateType);
	SHRateType baseRateType = shExtractBaseRateType(self.rateType);
	return baseRateType == SH_YEARLY_RATE ? @"Interval: Every year" : @"Interval: Every month";
}


-(NSString*)pluralFormatString {
	validateRateType(self.rateType);
	SHRateType baseRateType = shExtractBaseRateType(self.rateType);
	return baseRateType == SH_YEARLY_RATE ? @"Interval: Every %ld years" : @"Interval: Every %ld months";
}

@end
