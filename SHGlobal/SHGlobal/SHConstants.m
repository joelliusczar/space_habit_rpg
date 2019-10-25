//
//	constants.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/18/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHConstants.h"

NSInteger const SH_PM_PRIME = 2;
NSInteger const SH_AM_PRIME = 43;


NSString* const SH_DAILY_TRANSACTION_ENTITY_NAME = @"DailyTransaction";
NSString* const SH_COUNTER_TRANSACTION_ENTITY_NAME = @"HabitTransaction";
NSString* const SH_TODO_TRANSACTION_ENTITY_NAME = @"TodoTransaction";
NSString* const SH_GOOD_TRANSACTION_ENTITY_NAME = @"GoodTransaction";
NSString* const HERO_TRANSACTION_ENTITY_NAME = @"HeroTransaction";
NSString* const SH_SECTOR_TRANSACTION_ENTITY_NAME = @"SHSectorTransaction";
NSString* const SH_MONSTER_TRANSACTION_ENTITY_NAME = @"MonsterTransaction";


u_int32_t const SH_POTENTIAL_WEEKS_IN_MONTH_NUM = 5;
u_int32_t const SH_MAX_MONSTER_RAND_UP_BOUND = 11;
u_int32_t const SH_MAX_MONSTER_LOW_BOUND = 5;
u_int32_t const SH_SECTOR_LVL_RANGE = 10;
u_int32_t const SH_MONSTER_LVL_RANGE = 10;
u_int32_t const SH_TYPE_INCR_SIZE = 2;
u_int32_t const SH_MIN_ZONE_CHOICE_COUNT = 3;
u_int32_t const SH_MAX_ZONE_CHOICE_RAND_UP_BOUND = 3;
NSString * const SH_NOTIFY_CAT_ID = @"SHReminder";
NSString* const SH_ALL_DAYS_JSON = @"{\"daysOfWeek\":[],\"daysOfMonth\":[],\"daysOfYear\":[],"
"\"daysOfWeek_INV\":[],\"daysOfMonth_INV\":[],\"daysOfYear_INV\":[], \"weeklyInterval\": 1,"
"\"monthlyInterval\":1,\"yearlyInterval\":1, \"weeklyInterval_INV\": 1, "
"\"monthlyInterval_INV\":1,\"yearlyInterval_INV\":1, \"dailyInterval\":1, \"dailyIntervalInv\":1}";


NSString* const SH_TRANSACTION_TYPE_KEY = @"TransactionType";
NSString* const SH_TRANSACTION_TYPE_CREATE = @"ADDED";
NSString* const SH_TRANSACTION_TYPE_BATCH_DELETE = @"BATCH_DELETE";
NSString* const SH_REPORT_USER_ID_KEY = @"reportUserId";

int const SH_MINUTES_IN_HOUR = 60;
int const SH_HOURS_IN_DAY = 24;
int const SH_DAY_HALF = 12;



NSString* const SH_ORDINAL_WEEK_KEY = @"ORDINAL_WEEK";
NSString* const SH_DAY_OF_WEEK_KEY = @"DAY_OF_WEEK";
NSString* const SH_MONTH_KEY = @"MONTH";
NSString* const SH_DAY_OF_MONTH_KEY = @"DAY_OF_MONTH";

NSString* const SH_MAJOR_ORDINAL = @"MAJOR_ORDINAL";
NSString* const SH_MINOR_ORDINAL = @"MINOR_ORDINAL";

NSString* const SH_BACKRANGE_KEY = @"BACKRANGE";
NSString* const SH_FORRANGE_KEY = @"FORRANGE";
NSString* const SH_IS_DAY_ACTIVE_KEY = @"IS_DAY_ACTIVE";


