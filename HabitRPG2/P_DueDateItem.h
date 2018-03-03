//
//  P_DueDateWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reminder+CoreDataClass.h"

@import CoreData;

@protocol P_DueDateWrapper <NSObject>
@property (readonly,nonatomic) NSDate *nextDueTime;
@property (readonly,nonatomic) NSInteger maxDaysBefore;
@property (readonly,nonatomic) NSString *taskTitle;
@property (readonly,nonatomic) NSMutableDictionary *simpleMapable;
-(NSOrderedSet<Reminder *> *)getReminderSet;
-(void)addNewReminder:(Reminder *)reminder;
-(void)removeReminder:(Reminder *)reminder;
@end
