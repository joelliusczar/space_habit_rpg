////
////  Daily+CoreDataClass.m
////  HabitRPG2
////
////  Created by Joel Pridgen on 11/5/16.
////  Copyright © 2016 Joel Pridgen. All rights reserved.
////
//
//#import "Daily+CoreDataClass.h"
//#import <SHCommon/SHSingletonCluster.h>
//#import <SHCommon/NSDate+DateHelper.h>
//#import <SHCommon/NSMutableDictionary+Helper.h>
//#import <SHCommon/NSObject+Helper.h>
//#import <SHData/NSManagedObjectContext+Helper.h>
//#import "Reminder+CoreDataClass.h"
//#import <SHGlobal/SHConstants.h>
//#import "SHRateTypeHelper.h"
//#import <SHDaily_C.h>
//
//@interface Daily()
//@end
//
//@implementation Daily
//
//
//@synthesize isTouched;
//
//
//@synthesize activeDaysDict = _activeDaysDict;
//-(NSMutableDictionary *)activeDaysDict{
//    if(nil==_activeDaysDict){
//        _activeDaysDict = [NSMutableDictionary jsonStringToDict:self.activeDays];
//    }
//    return _activeDaysDict;
//}
//
//
//-(BOOL)isInverseRateType{
//    return isInverseRateType(self.rateType);
//}
//
//
//-(NSUInteger)reminderCount{
//  return self.daily_remind.count;
//}
//
//-(NSMutableArray<SHRateValueItemDict *> *)inUseActiveDays{
//    return [self getActiveDaysForRateType:self.rateType];
//}
//
//
//-(NSString *)name_w:(NSString *)name{
//    self.isTouched = YES;
//    self.dailyName = name;
//    return name;
//}
//
//
//-(NSString *)noteText_w:(NSString *)noteText{
//    self.isTouched = YES;
//    self.note = noteText;
//    return noteText;
//}
//
//
//-(SHRateType)rateType_w:(SHRateType)rateType{
//    self.isTouched = YES;
//    self.rateType = rateType;
//    return rateType;
//}
//
//
//-(NSInteger)rate_w:(int)rate{
//    self.isTouched = YES;
//    if(rate > 366){
//        rate = 366;
//    }
//    if(rate < 1){
//        rate = 1;
//    }
//    self.rate = rate;
//    return rate;
//}
//
//
//int checkImportanceRange(int importance){
//    if(importance > 10){
//        return 10;
//    }
//    if(importance < 0){
//        return 0;
//    }
//    return importance;
//}
//
//
//-(NSInteger)urgency_w:(int)urgency{
//    self.isTouched = YES;
//    urgency = checkImportanceRange(urgency);
//    self.urgency = urgency;
//    return urgency;
//}
//
//
//-(NSInteger)difficulty_w:(int)difficulty{
//    self.isTouched = YES;
//    difficulty = checkImportanceRange(difficulty);
//    self.difficulty = difficulty;
//    return difficulty;
//}
//
//
//-(NSInteger)streak_w:(int)streak{
//    self.isTouched = YES;
//    self.streakLength = streak;
//    return streak;
//}
//
//#warning This may need to move elsewhere
////
////-(NSDate *)nextDueTime{
////    NSDate *checkinDate = self.lastActivationTime?
////                            self.lastActivationTime:
////                            self.lastUpdateTime;
////    switch(self.rateType){
////
////        case SH_YEARLY_RATE:
////        case SH_YEARLY_RATE_INVERSE:
////        case SH_MONTHLY_RATE:
////        case MONTHLY_RATE_INVERSE:
////        case SH_WEEKLY_RATE:
////        {
////
////        }
////        case SH_WEEKLY_RATE_INVERSE:
////        {
////
////        }
////        case SH_DAILY_RATE:
////        {
////            return [self nextDueTime_DAILY:checkinDate];
////        }
////        case SH_DAILY_RATE_INVERSE:
////        {
////            return [self nextDueTime_DAILY_INVERSE:checkinDate];
////        }
////    }
////    return nil;
////}
//
//#warning TODO: this day start may need to change
//-(int)daysUntilDue{
//  //the hour was originally some sort of settings thing
//  //that was adding complications and, since this is just a display
//  //value, even we did switch our day start, I think it would
//  //confuse to have, for example if our day start was 2PM, next Sunday be 8 days
//  //from now at 1, but 7 days from now at 1:30
//  NSDate *roundedDownToday = [[NSDate date] setHour:0 minute:0 second:0];
//  return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
//}
//
//
//-(NSInteger)maxDaysBefore{
//    return self.rate;
//}
//
//
//-(NSString *)taskTitle{
//    return self.dailyName;
//}
//
//
//-(SHReminderDTO*)ReminderAtIndex:(NSUInteger)index{
//  SHReminderDTO *dto = [ReminderDTO new];
//  Reminder *r = self.daily_remind[index];
//  dto.daysBeforeDue = r.daysBeforeDue;
//  dto.reminderHour = r.reminderHour;
//  dto.objectID = r.objectID;
//  
//  return dto;
//}
//
//
//-(void)addNewReminder:(SHReminderDTO*)reminder{
//  NSManagedObjectContext *context = self.managedObjectContext;
//  NSAssert(context,@"Can not associate a reminder to a Daily that is not in context");
//  Reminder *reminderCD = (Reminder*)[context newEntity:Reminder.entity];
//  [reminderCD copyFrom:reminder];
//  [self addDaily_remindObject:reminderCD];
//}
//
//- (SHReminderDTO *)reminderAtIndex:(NSUInteger)index {
//  SHReminderDTO *dto = [SHReminderDTO new];
//  Reminder *reminder = self.daily_remind[index];
//  [dto dtoCopyFrom:reminder];
//  return dto;
//}
//
//
//-(void)removeReminderAtIndex:(NSUInteger)index {
//  Reminder *reminder = self.daily_remind[index];
//  [self removeDaily_remindObject:reminder];
//}
//
//
////so that we don't have to map all of the relationships
//-(NSMutableDictionary *)simpleMapable{
//    NSMutableDictionary *mappedData = [NSMutableDictionary dictionary];
//    //since NSDates don't play with JSON,I'm going to overrite these
//    //guys here
//    [self copyInto:mappedData];
//    [mappedData
//     setValue:[NSNumber numberWithDouble:self.lastActivationTime.timeIntervalSince1970]
//     forKey:@"lastActivationTime"];
//    [mappedData
//     setValue:[NSNumber numberWithDouble:self.rollbackActivationTime.timeIntervalSince1970]
//     forKey:@"rollbackActivationTime"];
//    return mappedData;
//}
//
//
////This method is not really necessary but using it will help my flow in
////viewDidLoad so that I didn't have a weird flag in there denoting that the
////model already existed. Besides, this makes things sorta more explicit
//-(void)setupDefaults{
//    self.activeDays = ALL_DAYS_JSON;
//    self.rateType = SH_WEEKLY_RATE;
//    self.dailyName = @"";
//    self.difficulty = 3;
//    self.urgency = 3;
//    self.note = @"";
//    self.rate = 1;
//    self.streakLength = 0;
//}
//
//
//-(void)preSave{
//    self.activeDays = [NSMutableDictionary dictToString:self.activeDaysDict];
//}
//
//@end
