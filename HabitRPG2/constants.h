//
//  constants.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//



#import <Foundation/Foundation.h>
@import CoreGraphics;

typedef NS_ENUM(NSUInteger,dailyStatus) {
    INCOMPLETE = 0
    ,COMPLETE = 1};

typedef NS_ENUM(NSInteger,enviromentCode) {
    ENV_DEFAULT =0
    ,ENV_BETA = 1<<0
    ,ENV_UTEST = 1<<1
};

typedef NS_ENUM(NSInteger,hourFormatType){
    BLANK =0
    ,ZERO_BASED_12_HOUR = 1<<0
    ,ONE_BASED_12_HOUR = 1<<1
    ,ZERO_BASED_24_HOUR = 1<<2
    ,ONE_BASED_24_HOUR = 1<<3
};

typedef NS_ENUM(NSInteger,gameState) {
    GAME_STATE_UNINITIALIZED =0
    ,GAME_STATE_INITIALIZED = 1
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
extern u_int32_t const MAX_MONSTER_RAND_UP_BOUND;
extern u_int32_t const MAX_MONSTER_LOW_BOUND;
extern u_int32_t const ZONE_LVL_RANGE;
extern u_int32_t const MONSTER_LVL_RANGE;
extern NSTimeInterval const CHARACTER_DELAY;
extern u_int32_t const MIN_ZONE_CHOICE_COUNT;
extern u_int32_t const MAX_ZONE_CHOICE_RAND_UP_BOUND;
extern CGFloat const ZONE_CHOICE_ROW_HEIGHT;

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
