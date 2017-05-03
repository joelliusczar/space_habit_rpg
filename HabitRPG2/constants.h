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
    ,ENV_UTEST = 1
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

extern u_int32_t const DAYS_IN_WEEK;
extern u_int32_t const MAX_MONSTER_RAND_UP_BOUND;
extern u_int32_t const MAX_MONSTER_LOW_BOUND;
extern u_int32_t const ZONE_LVL_RANGE;
extern u_int32_t const MONSTER_LVL_RANGE;
extern NSTimeInterval const CHARACTER_DELAY;
extern u_int32_t const MIN_ZONE_CHOICE_COUNT;
extern u_int32_t const MAX_ZONE_CHOICE_RAND_UP_BOUND;
extern CGFloat const ZONE_CHOICE_ROW_HEIGHT;


//zone groups
extern NSString* const LVL_0_ZONES;
extern NSString* const LVL_1_ZONES;
extern NSString* const LVL_5_ZONES;
extern NSString* const LVL_10_ZONES;
extern NSString* const LVL_15_ZONES;
extern NSString* const LVL_20_ZONES;
extern NSString* const LVL_25_ZONES;
extern NSString* const LVL_30_ZONES;
