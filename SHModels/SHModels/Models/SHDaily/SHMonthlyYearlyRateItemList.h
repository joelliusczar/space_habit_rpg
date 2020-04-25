//
//  SHMonthlyYearlyRateItemList.h
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonthlyYearlyRateItem.h"
#import "SHModelConstants.h"
#import "SHIntervalItemFormat.h"
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHMonthlyYearlyRateItemList : SHIntervalItemFormat
@property (readonly,nonatomic) NSUInteger count;
@property (copy,nonatomic) void (^touchCallback)(void);
-(instancetype)initWithActiveDays:(NSMutableArray<SHItervalItemDict*>*)activeDays;
-(NSUInteger)addRateItem:(SHMonthlyYearlyRateItem*)rateItem;
-(void)removeRateItemAtIndex:(NSUInteger)index;
-(SHMonthlyYearlyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx;
-(NSMutableArray<SHItervalItemDict*>*)convertToSaveble;
@end

@interface SHMonthlyRateItemList : SHMonthlyYearlyRateItemList

@end

@interface SHYearlyRateItemList : SHMonthlyYearlyRateItemList

@end

NS_ASSUME_NONNULL_END
