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
@property (assign, nonatomic) NSUInteger weeklyDayStart;
@property (readonly, nonatomic) NSString *weekDescription;
@property (readonly, nonatomic, nullable) NSArray<NSString*> *weekKeysBasedOnWeekStart;
-(instancetype)initWithRateItemArray:(NSArray<SHRateItemDict*>*)rateItemArray;
-(SHWeeklyRateItem*)objectAtIndexedSubscript:(NSUInteger)idx;
-(void)setDayOfWeek:(NSUInteger)dayIdx to:(BOOL)newValue;
-(NSMutableArray<SHRateItemDict*>*)convertToSaveble;
-(NSUInteger)findPrevActiveDayIdx:(NSUInteger)weekdayIdx;
-(SHRateValueItem *)convertObjCRateItemToC;
+(NSString *)weekDayKeyToFullName:(NSString*)dayKey;
@end

NS_ASSUME_NONNULL_END
