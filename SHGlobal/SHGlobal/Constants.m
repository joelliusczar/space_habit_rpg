//
//  constants.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Constants.h"

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


u_int32_t const POTENTIAL_WEEKS_IN_MONTH_NUM = 5;
u_int32_t const MAX_MONSTER_RAND_UP_BOUND = 11;
u_int32_t const MAX_MONSTER_LOW_BOUND = 5;
u_int32_t const ZONE_LVL_RANGE = 10;
u_int32_t const MONSTER_LVL_RANGE = 10;
u_int32_t const TYPE_INCR_SIZE = 2;
u_int32_t const MIN_ZONE_CHOICE_COUNT = 3;
u_int32_t const MAX_ZONE_CHOICE_RAND_UP_BOUND = 3;
NSString * const NOTIFY_CAT_ID = @"SHReminder";
NSString* const ALL_DAYS_JSON = @"{\"daysOfWeek\":[],\"daysOfMonth\":[],\"daysOfYear\":[],"
"\"daysOfWeek_INV\":[],\"daysOfMonth_INV\":[],\"daysOfYear_INV\":[]}";


NSString* const TRANSACTION_TYPE_KEY = @"TransactionType";
NSString* const TRANSACTION_TYPE_CREATE = @"ADDED";
NSString* const REPORT_USER_ID_KEY = @"reportUserId";

int const MINUTES_IN_HOUR = 60;
int const HOURS_IN_DAY = 24;
int const DAY_HALF = 12;



NSString* const ORDINAL_WEEK_KEY = @"ORDINAL_WEEK";
NSString* const DAY_OF_WEEK_KEY = @"DAY_OF_WEEK";
NSString* const MONTH_KEY = @"MONTH";
NSString* const DAY_OF_MONTH_KEY = @"DAY_OF_MONTH";

NSString* const BACKRANGE_KEY = @"BACKRANGE";
NSString* const FORRANGE_KEY = @"FORRANGE";
NSString* const IS_DAY_ACTIVE_KEY = @"IS_DAY_ACTIVE";

int const DAY_LEN = 84600; //only use this for extremely simple calculations, e.g. a week or less


