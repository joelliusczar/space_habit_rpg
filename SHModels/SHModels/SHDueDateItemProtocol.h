//
//  P_DueDateWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHReminder.h"
#import "SHReminderDTO.h"
@import Foundation;
@import SHCommon;
@import CoreData;

@protocol SHDueDateItemProtocol <NSObject,SHMappableProtocol>
@property (readonly,nonatomic) NSDate* nextDueDate;
@property (readonly,nonatomic) NSInteger daysUntilDue;
/*
maxDaysBeforeSpan is used as a selection limit. The user is not allowed
to set reminders to ranges greater than {maxDaysBeforeSpan} before the
due date of an item
*/
@property (readonly,nonatomic) NSInteger maxDaysBeforeSpan;
@property (readonly,nonatomic) NSUInteger reminderCount;
-(SHReminder*)reminderAtIndex:(NSUInteger)index;
-(void)addNewReminder:(SHReminder*)reminder;
-(void)removeReminderAtIndex:(NSUInteger)index;
@end
