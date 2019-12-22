//
//	SHMonthlyYearlyRateItem.m
//	SHModels
//
//	Created by Joel Pridgen on 5/5/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonthlyYearlyRateItem.h"

@implementation SHMonthlyYearlyRateItem

-(instancetype)initWithMajorOrdinal:(NSInteger)majorOrdinal
	minorOrdinal:(NSInteger)minorOrdinal
{
	if(self = [super init]){
		_majorOrdinal = majorOrdinal;
		_minorOrdinal = minorOrdinal;
	}
	return self;
}


-(BOOL)isEqual:(id)object{
	if(![object isKindOfClass:SHMonthlyYearlyRateItem.class]) return false;
	SHMonthlyYearlyRateItem *other = (SHMonthlyYearlyRateItem*)object;
	BOOL areMajorsEqual = self.majorOrdinal == other.majorOrdinal;
	BOOL areMinorsEqual = self.minorOrdinal == other.minorOrdinal;
	return areMajorsEqual && areMinorsEqual;
}


-(NSUInteger)hash{
	NSUInteger result = (self.majorOrdinal & (~0UL << 56)) | (self.minorOrdinal << 56);
	return result;
}


@end
