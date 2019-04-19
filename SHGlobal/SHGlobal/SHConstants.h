//
//  constants.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,shDailyStatus) {
    SH_INCOMPLETE = 0
    ,SH_COMPLETE = 1};

typedef NS_ENUM(NSInteger,shEnviromentCode) {
    SH_ENV_DEFAULT =0
    ,SH_ENV_BETA = 1<<0
    ,SH_ENV_UTEST = 1<<1
};

typedef NS_ENUM(NSInteger,shWeekdayFlags){
    SH_NODAY = 0
    ,SH_MONDAY = 1<<0
    ,SH_TUESDAY = 1<<1
    ,SH_WEDNESDAY = 1<<2
    ,SH_THURSDAY = 1<<3
    ,SH_FRIDAY = 1<<4
    ,SH_SATURDAY = 1<<5
    ,SH_SUNDAY = 1<<6
    ,SH_ALLDAYS = SH_MONDAY|SH_TUESDAY|SH_WEDNESDAY|SH_THURSDAY|SH_FRIDAY|SH_SATURDAY|SH_SUNDAY
};

#define SH_INVERSE_RATE_MODIFIER (1<<7)

typedef NS_ENUM(int,SHRateType){
    SH_DAILY_RATE = 0
    ,SH_WEEKLY_RATE = 1<<0
    ,SH_MONTHLY_RATE = 1<<1
    ,SH_YEARLY_RATE = 1<<2
    ,SH_DAILY_RATE_INVERSE = SH_DAILY_RATE|SH_INVERSE_RATE_MODIFIER
    ,SH_WEEKLY_RATE_INVERSE = SH_WEEKLY_RATE|SH_INVERSE_RATE_MODIFIER
    ,SH_MONTHLY_RATE_INVERSE = SH_MONTHLY_RATE|SH_INVERSE_RATE_MODIFIER
    ,SH_YEARLY_RATE_INVERSE = SH_YEARLY_RATE|SH_INVERSE_RATE_MODIFIER
};

typedef NS_ENUM(NSInteger,SHHourFormatType){
    SH_BLANK =0
    ,SH_ZERO_BASED_12_HOUR = 1<<0
    ,SH_ONE_BASED_12_HOUR = 1<<1
    ,SH_ZERO_BASED_24_HOUR = 1<<2
    ,SH_ONE_BASED_24_HOUR = 1<<3
};

typedef NS_ENUM(NSInteger,SHGameState) {
    SH_GAME_STATE_UNINITIALIZED = 0
    ,SH_GAME_STATE_INITIALIZED = 1
};




extern NSString* const SH_DAILY_ENTITY_NAME;
extern NSString* const SH_COUNTER_ENTITY_NAME;
extern NSString* const SH_TODO_ENTITY_NAME;
extern NSString* const SH_ITEM_ENTITY_NAME;
extern NSString* const SH_HERO_ENTITY_NAME;
extern NSString* const SH_SETTINGS_ENTITY_NAME;
extern NSString* const SH_SECTOR_ENTITY_NAME;
extern NSString* const SH_MONSTER_ENTITY_NAME;
extern NSString* const SH_SUFFIX_ENTITY_NAME;

extern NSString* const SH_DAILY_TRANSACTION_ENTITY_NAME;
extern NSString* const SH_COUNTER_TRANSACTION_ENTITY_NAME;
extern NSString* const SH_TODO_TRANSACTION_ENTITY_NAME;
extern NSString* const SH_GOOD_TRANSACTION_ENTITY_NAME;
extern NSString* const SH_SECTOR_TRANSACTION_ENTITY_NAME;
extern NSString* const SH_MONSTER_TRANSACTION_ENTITY_NAME;

extern u_int32_t const SH_POTENTIAL_WEEKS_IN_MONTH_NUM;
extern u_int32_t const SH_MAX_MONSTER_RAND_UP_BOUND;
extern u_int32_t const SH_MAX_MONSTER_LOW_BOUND;
extern u_int32_t const SH_SECTOR_LVL_RANGE;
extern u_int32_t const SH_MONSTER_LVL_RANGE;
extern u_int32_t const SH_TYPE_INCR_SIZE;
extern u_int32_t const SH_MIN_ZONE_CHOICE_COUNT;
extern u_int32_t const SH_MAX_ZONE_CHOICE_RAND_UP_BOUND;
extern NSString* const SH_NOTIFY_CAT_ID;
extern NSString* const SH_ALL_DAYS_JSON;


extern NSString* const SH_TRANSACTION_TYPE_KEY;
extern NSString* const SH_TRANSACTION_TYPE_CREATE;
extern NSString* const SH_REPORT_USER_ID_KEY;

extern int const SH_MINUTES_IN_HOUR;
extern int const SH_HOURS_IN_DAY;
extern int const SH_DAY_HALF;

extern NSString* const SH_ORDINAL_WEEK_KEY;
extern NSString* const SH_DAY_OF_WEEK_KEY;
extern NSString* const SH_MONTH_KEY;
extern NSString* const SH_DAY_OF_MONTH_KEY;

extern NSString * const SH_BACKRANGE_KEY;
extern NSString * const SH_FORRANGE_KEY;
extern NSString * const SH_IS_DAY_ACTIVE_KEY;

extern int const SH_DAY_LEN;

