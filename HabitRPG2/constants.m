//
//  constants.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "constants.h"

NSInteger const PM_PRIME = 2;
NSInteger const AM_PRIME = 43;

NSString* const DAILY_ENTITY_NAME = @"Daily";
NSString* const HABIT_ENTITY_NAME = @"Habit";
NSString* const TODO_ENTITY_NAME = @"Todo";
NSString* const GOOD_ENTITY_NAME = @"Good";
NSString* const HERO_ENTITY_NAME = @"Hero";
NSString* const SETTINGS_ENTITY_NAME = @"Settings";
NSString* const ZONE_ENTITY_NAME = @"Zone";
NSString* const MONSTER_ENTITY_NAME = @"Monster";
NSString* const DATA_INFO_ENTITY_NAME = @"DataInfo";
NSString* const SUFFIX_ENTITY_NAME = @"Suffix";

NSString* const DAILY_TRANSACTION_ENTITY_NAME = @"DailyTransaction";
NSString* const HABIT_TRANSACTION_ENTITY_NAME = @"HabitTransaction";
NSString* const TODO_TRANSACTION_ENTITY_NAME = @"TodoTransaction";
NSString* const GOOD_TRANSACTION_ENTITY_NAME = @"GoodTransaction";
NSString* const HERO_TRANSACTION_ENTITY_NAME = @"HeroTransaction";
NSString* const ZONE_TRANSACTION_ENTITY_NAME = @"ZoneTransaction";
NSString* const MONSTER_TRANSACTION_ENTITY_NAME = @"MonsterTransaction";


u_int32_t const DAYS_IN_WEEK = 7;
u_int32_t const MAX_MONSTER_RAND_UP_BOUND = 11;
u_int32_t const MAX_MONSTER_LOW_BOUND = 5;
u_int32_t const ZONE_LVL_RANGE = 10;
u_int32_t const MONSTER_LVL_RANGE = 10;
NSTimeInterval const CHARACTER_DELAY = .01;
u_int32_t const MIN_ZONE_CHOICE_COUNT = 3;
u_int32_t const MAX_ZONE_CHOICE_RAND_UP_BOUND = 3;
CGFloat const ZONE_CHOICE_ROW_HEIGHT = 75;
CGFloat const EDIT_SCREEN_TOP_CONTROL_HEIGHT = 60;
NSString * const NOTIFY_CAT_ID = @"SHReminder";
NSString* const ALL_DAYS_JSON = @"{\"SUN\":1,\"MON\":1,\"TUE\":1,"
"\"WED\":1,\"THR\":1,\"SAT\":1}";

CGFloat const SUB_TABLE_CELL_HEIGHT = 44;
NSInteger const SUB_TABLE_MAX_ROWS = 4;
CGFloat const SUB_TABLE_MAX_HEIGHT = SUB_TABLE_CELL_HEIGHT*SUB_TABLE_MAX_ROWS;

NSString* const TRANSACTION_TYPE_KEY = @"TransactionType";
NSString* const TRANSACTION_TYPE_CREATE = @"ADDED";
NSString* const REPORT_USER_ID_KEY = @"reportUserId";

int const MINUTES_IN_HOUR = 60;
int const HOURS_IN_DAY = 24;
int const DAY_HALF = 12;


//zone groups
NSString* const LVL_0_ZONES = @"LVL_0_ZONES";
NSString* const LVL_1_ZONES = @"LVL_1_ZONES";
NSString* const LVL_5_ZONES = @"LVL_5_ZONES";
NSString* const LVL_10_ZONES = @"LVL_10_ZONES";
NSString* const LVL_15_ZONES = @"LVL_15_ZONES";
NSString* const LVL_20_ZONES = @"LVL_20_ZONES";
NSString* const LVL_25_ZONES = @"LVL_25_ZONES";
NSString* const LVL_30_ZONES = @"LVL_30_ZONES";

