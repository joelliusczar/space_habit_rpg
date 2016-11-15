//
//  constants.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,dailyStatus) {
    INCOMPLETE = 0
    ,COMPLETE = 1};

extern NSString* const DAILY_ENTITY_NAME;
extern NSString* const HERO_ENTITY_NAME;
extern NSString* const SETTINGS_ENTITY_NAME;
extern NSString* const ZONE_ENTITY_NAME;
extern NSString* const MONSTER_ENTITY_NAME;
extern u_int8_t const DAYS_IN_WEEK;
extern u_int8_t const MAX_MONSTER_RAND_UP_BOUND;
extern u_int8_t const MAX_MONSTER_LOW_BOUND;
extern u_int8_t const ZONE_LVL_RANGE;
