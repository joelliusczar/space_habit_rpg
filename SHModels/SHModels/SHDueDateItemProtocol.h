//
//  P_DueDateWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHReminder+CoreDataClass.h"
#import "SHReminderDTO.h"

@import CoreData;

@protocol SHDueDateItemProtocol <NSObject>
@property (readonly,nonatomic) NSDate *nextDueTime;
@property (readonly,nonatomic) NSInteger maxDaysBefore;
@property (readonly,nonatomic) NSString *taskTitle;
@property (readonly,nonatomic) NSMutableDictionary *simpleMapable;
@property (readonly,nonatomic) NSUInteger reminderCount;
-(SHReminderDTO*)reminderAtIndex:(NSUInteger)index;
-(void)addNewReminder:(SHReminderDTO*)reminder;
-(void)removeReminderAtIndex:(NSUInteger)index;
@end
