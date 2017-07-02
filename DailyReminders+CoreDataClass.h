//
//  DailyReminders+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "P_Reminder.h"

@class Daily;

NS_ASSUME_NONNULL_BEGIN

@interface DailyReminders : NSManagedObject<P_Reminder>

@end

NS_ASSUME_NONNULL_END

#import "DailyReminders+CoreDataProperties.h"
