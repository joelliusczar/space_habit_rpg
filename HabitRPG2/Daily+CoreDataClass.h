//
//  Daily+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "P_DueDateWrapper.h"
#import "constants.h"

@class DailySubTask;

NS_ASSUME_NONNULL_BEGIN

@interface Daily : NSManagedObject <P_DueDateWrapper>
@property (readonly,nonatomic) int daysUntilDue;
@property (strong,nonatomic) NSMutableDictionary *activeDaysDict;
@property (readonly,nonatomic) NSMutableArray<RateValueItemDict *> *inUseActiveDays;
@property (readonly,nonatomic) BOOL isInverseRateType;
@property (assign,nonatomic) BOOL isTouched;
-(NSString *)name_w:(NSString *)name;
-(NSString *)noteText_w:(NSString *)noteText;
-(NSInteger)urgency_w:(int)urgency;
-(NSInteger)difficulty_w:(int)difficulty;
-(RateType)rateType_w:(RateType)rateType;
-(NSInteger)rate_w:(int)rate;
-(NSInteger)streak_w:(int)streak;
-(void)setupDefaults;
-(void)preSave;
@end

NS_ASSUME_NONNULL_END

#import "Daily+CoreDataProperties.h"
#import "Daily+ActiveDays.h"
#import "Daily+Mapable.h"
