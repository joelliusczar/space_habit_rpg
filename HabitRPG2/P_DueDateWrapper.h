//
//  P_DueDateWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_Reminder.h"

@import CoreData;

@protocol P_DueDateWrapper <NSObject>
@property (readonly,nonatomic) NSDate *nextDueTime;
-(NSOrderedSet<NSManagedObject<P_Reminder> *> *)getReminderSet;
@end
