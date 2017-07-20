//
//  WeekdayEnum.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/11/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef WeekdayEnum_h
#define WeekdayEnum_h

typedef NS_ENUM(NSInteger,weekdayFlags){
    NODAY = 0
    ,MONDAY = 1<<0
    ,TUESDAY = 1<<1
    ,WEDNESDAY = 1<<2
    ,THURSDAY = 1<<3
    ,FRIDAY = 1<<4
    ,SATURDAY = 1<<5
    ,SUNDAY = 1<<6
    ,ALLDAYS = MONDAY|TUESDAY|WEDNESDAY|THURSDAY|FRIDAY|SATURDAY|SUNDAY
};

#endif /* WeekdayEnum_h */
