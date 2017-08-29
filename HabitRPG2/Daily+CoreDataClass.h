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

@class DailySubTask;

NS_ASSUME_NONNULL_BEGIN

@interface Daily : NSManagedObject <P_DueDateWrapper>
@property (nonatomic,assign) NSInteger rowNum;
@property (nonatomic,assign) NSInteger sectionNum;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@property (readonly,nonatomic) int daysUntilDue;
@property (strong,nonatomic) NSMutableDictionary *activeDaysDict;
-(void)copyInto:(NSObject *)object;
-(NSString *)name_w:(NSString *)name;
-(NSString *)noteText_w:(NSString *)noteText;
-(NSInteger)urgency_w:(int)urgency;
-(NSInteger)difficulty_w:(int)difficulty;
-(NSInteger)rate_w:(int)rate;
-(NSInteger)streak_w:(int)streak;
@end

NS_ASSUME_NONNULL_END

#import "Daily+CoreDataProperties.h"
