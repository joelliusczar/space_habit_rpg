//
//	SHMonthlyYearlyRateItemList.m
//	SHModels
//
//	Created by Joel Pridgen on 5/5/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonthlyYearlyRateItemList.h"
#import "SHIntervalTypeHelper.h"

@interface SHMonthlyYearlyRateItemList ()
@property (strong,nonatomic) NSMutableArray<SHMonthlyYearlyRateItem*> *backend;
@end

@implementation SHMonthlyYearlyRateItemList


static SHMonthlyYearlyRateItem* _Nonnull mapDictToMonthlyYearly(SHItervalItemDict * _Nonnull item, NSUInteger idx){
	(void)idx;
	NSInteger major = item[SH_MAJOR_ORDINAL].integerValue;
	NSInteger minor = item[SH_MINOR_ORDINAL].integerValue;
	SHMonthlyYearlyRateItem *rateItem = [[SHMonthlyYearlyRateItem alloc]
		initWithMajorOrdinal:major
		minorOrdinal:minor];

	return rateItem;
}


-(instancetype)initWithActiveDays:(NSMutableArray<SHItervalItemDict*>*)activeDays{
	if(self = [super init]){
		_backend = [activeDays mapItemsTo_f:mapDictToMonthlyYearly];
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


static NSDictionary* mapMonthlyYearlyToDict(SHMonthlyYearlyRateItem *item, NSUInteger idx){
	(void)idx;
	SHItervalItemDict *dict = @{
		SH_MAJOR_ORDINAL : @(item.majorOrdinal),
		SH_MINOR_ORDINAL : @(item.minorOrdinal)
	};
	return dict;
}


-(NSMutableArray<SHItervalItemDict*>*)convertToSaveble {
	return [self.backend mapItemsTo_f:mapMonthlyYearlyToDict];
}


@end


@implementation SHMonthlyRateItemList

+(NSString*)singularFormatString {
	return @"Every month";
}


+(NSString*)pluralFormatString {
	return @"Every %ld months";
}


-(NSString*)intervalLabelDescription {
	NSString *desc = [NSString stringWithFormat:@"%@\n  %ld times a month",
		self.intervalDescription,
		self.backend.count];
	return desc;
}

@end


@implementation SHYearlyRateItemList

+(NSString*)singularFormatString {
	return @"Every year";
}


+(NSString*)pluralFormatString {
	return @"Every %ld years";
}


-(NSString*)intervalLabelDescription {
	NSString *desc = [NSString stringWithFormat:@"%@\n  %ld times a year",
		self.intervalDescription,
		self.backend.count];
	return desc;
}

@end
