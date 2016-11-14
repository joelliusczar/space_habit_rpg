//
//  DailyHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily+CoreDataClass.h"
#import "CommonUtilities.h"



@interface DailyHelper : NSObject
-(instancetype)initWithCommonUtilities:(CommonUtilities *)utility;
-(BOOL)isDailyCompleteForTheDay:(Daily *)daily;
-(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(int32_t)rate;
-(int32_t)calculateActiveDaysHash:(NSMutableArray *)activeDays;
-(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash;
@end
