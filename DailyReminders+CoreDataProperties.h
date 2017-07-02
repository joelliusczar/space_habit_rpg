//
//  DailyReminders+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyReminders+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DailyReminders (CoreDataProperties)

+ (NSFetchRequest<DailyReminders *> *)fetchRequest;

@property (nonatomic) int32_t daysBeforeDue;
@property (nullable, nonatomic, copy) NSDate *reminderHour;
@property (nullable, nonatomic, retain) Daily *remind_daily;

@end

NS_ASSUME_NONNULL_END
