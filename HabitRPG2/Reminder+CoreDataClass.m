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
#import "NSDate+DateHelper.h"
#import "constants.h"

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

-(NSMutableDictionary *)mapable{
    NSMutableDictionary *mappedData = [NSMutableDictionary dictionary];
    [self copyInto:mappedData];
    //I don't want to risk a circular reference by trying to map this
    //besides, I don't really care
    [mappedData removeObjectForKey:@"remind_daily"];
    [mappedData setValue:[self.reminderHour extractTimeInFormat:ZERO_BASED_24_HOUR]
                  forKey:@"reminderHour"];
    
    return mappedData;
}

-(void)copyInto:(NSObject *)object{
    [object setValue:[NSNumber numberWithInt:self.daysBeforeDue]
              forKey:@"daysBeforeDue"];
    [object setValue:self.reminderHour forKey:@"reminderHour"];
    [object setValue:self.lastUpdateTime forKey:@"lastUpdateTime"];
    [object setValue:self.notificationID forKey:@"notificationID"];

}

@end
