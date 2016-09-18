//
//  DailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyHelper.h"
#import "Daily.h"

@implementation DailyHelper

+(BOOL)isDailyCompleteForTheDay:(Daily *)daily{
    return NO;
}

+(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(int)rate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:rate];
    return [cal dateByAddingComponents:offsetComponents toDate:checkinDate options:0];
}

@end
