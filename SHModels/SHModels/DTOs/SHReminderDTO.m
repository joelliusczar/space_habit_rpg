//
//	SHReminderDTO.m
//	SHModels
//
//	Created by Joel Pridgen on 4/5/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHReminderDTO.h"
#import <SHCommon/NSObject+Helper.h>
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHCommon/NSDate+DateHelper.h>

@implementation SHReminderDTO


-(NSString *)synopsis{
	NSDateComponentsFormatter *format =
	[[NSDateComponentsFormatter alloc] init];
	format.allowedUnits = NSCalendarUnitHour|NSCalendarUnitMinute;
	
	NSDateComponents * components =
	[NSCalendar.currentCalendar
	 components:(NSCalendarUnitHour|NSCalendarUnitMinute)
	 fromDate:self.reminderHour];
	
	return [NSString stringWithFormat:@"Remind at:%@ %d days before",
			[format stringFromDateComponents:components],self.daysBeforeDue];
}

-(NSMutableDictionary *)mapable{
	NSMutableDictionary *mappedData = [NSMutableDictionary objectToDictionary:self];

	[mappedData setValue:[self.reminderHour extractTimeInFormat:SH_ZERO_BASED_24_HOUR]
		forKey:@"reminderHour"];
	
	return mappedData;
}


-(id)copyWithZone:(NSZone *)zone{
	(void)zone;
	return [self narrowCopy];
}


@end
