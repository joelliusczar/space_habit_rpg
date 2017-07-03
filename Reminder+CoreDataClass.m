//
//  Reminder+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Reminder+CoreDataClass.h"
#import "Daily+CoreDataClass.h"
#import "SingletonCluster.h"

@implementation Reminder

-(NSString *)synopsis{
    NSDateComponentsFormatter *format =
    [[NSDateComponentsFormatter alloc] init];
    format.allowedUnits = NSCalendarUnitHour|NSCalendarUnitMinute;
    
    NSDateComponents * components =
    [SharedGlobal.inUseCalendar
     components:(NSCalendarUnitHour|NSCalendarUnitMinute)
     fromDate:self.reminderHour];
    
    return [NSString stringWithFormat:@"Remind at:%@ %d days before",
            [format stringFromDateComponents:components],self.daysBeforeDue];
}

@end
