//
//  Reminder+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Reminder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest;

@property (nonatomic) int32_t daysBeforeDue;
@property (nullable, nonatomic, copy) NSDate *reminderHour;
@property (nullable, nonatomic, retain) Daily *remind_daily;

@end

NS_ASSUME_NONNULL_END