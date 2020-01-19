//
//  SHWeeklyRateItemList.h
//  SHModels
//
//  Created by Joel Pridgen on 12/21/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHWeeklyRateItem.h"
#import "SHModelConstants.h"
#import "SHIntervalItemFormat.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHWeeklyRateItemList : SHIntervalItemFormat
-(instancetype)initWithRateItemArray:(NSArray<SHRateItemDict*>*)rateItemArray;
-(SHWeeklyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx;
-(void)flipDayOfWeek:(NSUInteger)dayIdx;
-(NSMutableArray<SHRateItemDict*>*)convertToSaveble;
@end

NS_ASSUME_NONNULL_END
