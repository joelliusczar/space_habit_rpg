//
//  Reminder+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Reminder+CoreDataClass.h"
#import "Daily+CoreDataClass.h"
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHCommon/CommonUtilities.h>
#import <SHGlobal/Constants.h>

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

-(void)copyInto:(NSObject*)object{
  copyProp(self, object, @"objectID");
  copyBetween(self, object);
}


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
}


static void copyBetween(NSObject* from,NSObject* to){
  copyProp(from, to, @"daysBeforeDue");
  copyProp(from, to, @"reminderHour");
  copyProp(from, to, @"lastUpdateTime");
  copyProp(from, to, @"notificationID");
}

@end
