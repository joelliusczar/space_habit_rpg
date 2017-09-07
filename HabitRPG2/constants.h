//
//  constants.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreGraphics;

typedef NSDictionary<NSString *,NSNumber *> RateValueItemDict;

typedef NS_ENUM(NSUInteger,dailyStatus) {
    INCOMPLETE = 0
    ,COMPLETE = 1};

typedef NS_ENUM(NSInteger,enviromentCode) {
    ENV_DEFAULT =0
    ,ENV_BETA = 1<<0
    ,ENV_UTEST = 1<<1
};

#define INVERSE_RATE_MODIFIER (1<<7)

typedef NS_ENUM(int,RateType){
    DAILY_RATE = 0
    ,WEEKLY_RATE = 1<<0
    ,MONTHLY_RATE = 1<<1
    ,YEARLY_RATE = 1<<2
    ,WEEKLY_RATE_INVERSE = WEEKLY_RATE|INVERSE_RATE_MODIFIER
    ,MONTHLY_RATE_INVERSE = MONTHLY_RATE|INVERSE_RATE_MODIFIER
    ,YEARLY_RATE_INVERSE = YEARLY_RATE|INVERSE_RATE_MODIFIER
};

typedef NS_ENUM(NSInteger,hourFormatType){
    BLANK =0
    ,ZERO_BASED_12_HOUR = 1<<0
    ,ONE_BASED_12_HOUR = 1<<1
    ,ZERO_BASED_24_HOUR = 1<<2
    ,ONE_BASED_24_HOUR = 1<<3
};

typedef NS_ENUM(NSInteger,gameState) {
    GAME_STATE_UNINITIALIZED = 0
    ,GAME_STATE_INITIALIZED = 1
};

//may not even use these
extern NSInteger const PM_PRIME;
extern NSInteger const AM_PRIME;
typedef NS_ENUM(NSInteger,hourPrimes){
    PRIME_0 = 3
    ,PRIME_1 = 5
    ,PRIME_2 = 7
    ,PRIME_3 = 11
    ,PRIME_4 = 13
    ,PRIME_5 = 17
    ,PRIME_6 = 19
    ,PRIME_7 = 23
    ,PRIME_8 = 29
    ,PRIME_9 = 31
    ,PRIME_10 = 37
    ,PRIME_11 = 41
};

extern NSString* const DAILY_ENTITY_NAME;
extern NSString* const HABIT_ENTITY_NAME;
extern NSString* const TODO_ENTITY_NAME;
extern NSString* const GOOD_ENTITY_NAME;
extern NSString* const HERO_ENTITY_NAME;
extern NSString* const SETTINGS_ENTITY_NAME;
extern NSString* const ZONE_ENTITY_NAME;
extern NSString* const MONSTER_ENTITY_NAME;
extern NSString* const DATA_INFO_ENTITY_NAME;
extern NSString* const SUFFIX_ENTITY_NAME;

extern NSString* const DAILY_TRANSACTION_ENTITY_NAME;
extern NSString* const HABIT_TRANSACTION_ENTITY_NAME;
extern NSString* const TODO_TRANSACTION_ENTITY_NAME;
extern NSString* const GOOD_TRANSACTION_ENTITY_NAME;
extern NSString* const ZONE_TRANSACTION_ENTITY_NAME;
extern NSString* const MONSTER_TRANSACTION_ENTITY_NAME;

extern u_int32_t const DAYS_IN_WEEK;
extern u_int32_t const POTENTIAL_WEEKS_IN_MONTH_NUM;
extern u_int32_t const MAX_MONSTER_RAND_UP_BOUND;
extern u_int32_t const MAX_MONSTER_LOW_BOUND;
extern u_int32_t const ZONE_LVL_RANGE;
extern u_int32_t const MONSTER_LVL_RANGE;
extern NSTimeInterval const CHARACTER_DELAY;
extern u_int32_t const MIN_ZONE_CHOICE_COUNT;
extern u_int32_t const MAX_ZONE_CHOICE_RAND_UP_BOUND;
extern CGFloat const ZONE_CHOICE_ROW_HEIGHT;
extern CGFloat const EDIT_SCREEN_TOP_CONTROL_HEIGHT;
extern NSString* const NOTIFY_CAT_ID;
extern NSString* const ALL_DAYS_JSON;

extern CGFloat const SUB_TABLE_CELL_HEIGHT;
extern NSInteger const SUB_TABLE_MAX_ROWS;
extern CGFloat const SUB_TABLE_MAX_HEIGHT;

extern NSString* const TRANSACTION_TYPE_KEY;
extern NSString* const TRANSACTION_TYPE_CREATE;
extern NSString* const REPORT_USER_ID_KEY;

extern int const MINUTES_IN_HOUR;
extern int const HOURS_IN_DAY;
extern int const DAY_HALF;

//zone groups
extern NSString* const LVL_0_ZONES;
extern NSString* const LVL_1_ZONES;
extern NSString* const LVL_5_ZONES;
extern NSString* const LVL_10_ZONES;
extern NSString* const LVL_15_ZONES;
extern NSString* const LVL_20_ZONES;
extern NSString* const LVL_25_ZONES;
extern NSString* const LVL_30_ZONES;

extern int const HOUR_OF_DAY_COL;
extern int const MINUTE_COL;
extern int const DAYS_BEFORE_COL_IN_24_HOUR_CLOCK;
extern int const DAYS_BEFORE_COL_IN_12_HOUR_CLOCK;
extern int const AM_PM_COL;
extern int const AM_ROW;
extern int const PM_ROW;


extern NSString* const ORDINAL_WEEK_KEY;
extern NSString* const DAY_OF_WEEK_KEY;
extern NSString* const MONTH_KEY;
extern NSString* const DAY_OF_MONTH_KEY;
