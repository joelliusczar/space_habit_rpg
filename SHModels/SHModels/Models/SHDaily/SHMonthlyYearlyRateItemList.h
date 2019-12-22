//
//  SHMonthlyYearlyRateItemList.h
//  SHModels
//
//  Created by Joel Pridgen on 5/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonthlyYearlyRateItem.h"
#import "SHModelConstants.h"
#import "SHRateItemProtocol.h"
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHMonthlyYearlyRateItemList : SHObject<SHRateItemProtocol>
@property (readonly,nonatomic) NSUInteger count;
@property (assign, nonatomic) NSInteger intervalSize;
@property (assign, nonatomic) SHRateType rateType;
@property (copy,nonatomic) void (^touchCallback)(void);
-(instancetype)initWithActiveDays:(NSMutableArray<SHRateItemDict*>*)activeDays;
-(NSUInteger)addRateItem:(SHMonthlyYearlyRateItem*)rateItem;
-(void)removeRateItemAtIndex:(NSUInteger)index;
-(SHMonthlyYearlyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx;
-(NSMutableArray<SHRateItemDict*>*)convertToSaveble;
@end

NS_ASSUME_NONNULL_END
