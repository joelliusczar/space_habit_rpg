//
//  SHWeekIntervalItemList.h
//  SHModels
//
//  Created by Joel Pridgen on 12/21/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHModelConstants.h"
#import "SHIntervalItemFormat.h"
@import SHSpecial_C;

NS_ASSUME_NONNULL_BEGIN

/*
We will continue to store a week in sun-sat order
so that if the user marks a day as active but then switches
the first day, the activeness of that day won't get shifted
we will keep all the weird shifting localized to this section mostly
*/

@interface SHWeekIntervalItemList : SHIntervalItemFormat
@property (assign, nonatomic) int32_t weeklyDayStart;
@property (readonly, nonatomic) NSString *weekDescription;
@property (readonly, nonatomic, nullable) NSArray<NSString*> *weekKeysBasedOnWeekStart;
-(instancetype)initWithRateItemArray:(NSArray<SHItervalItemDict*>*)rateItemArray
	withWeekStartOffset:(int32_t)dayOffset;
-(struct SHWeekIntervalPoint*)objectAtIndexedSubscript:(NSUInteger)idx;
-(void)setDayOfWeek:(NSUInteger)dayIdx to:(bool)newValue;
-(NSMutableArray<SHItervalItemDict*>*)convertToSaveble;
-(struct SHWeekIntervalPointList)copyWeek;
+(nullable NSString *)weekDayKeyToFullName:(NSString*)dayKey;
@end

NS_ASSUME_NONNULL_END
