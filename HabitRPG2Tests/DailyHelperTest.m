//
//  DailyHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import "Daily+CoreDataClass.h"
#import "Daily+DailyHelper.h"
#import "NSDate+DateHelper.h"
#import "NSDate+testReplace.h"
#import "FlexibleConstants.h"

@interface DailyHelperTest : FrequentCase

@end

NSMutableArray<Daily *> *testDailies = nil;

@implementation DailyHelperTest

-(void)setUp {
    [super setUp];
    [NSDate swizzleThatShit];
    testDailies = [NSMutableArray array];
    int a0=0,a1=0,a2=0,a3=0,a4=0,a5=0;
    for(int i = 0;i<50;i++){
        testDailies[i] = [Daily constructDaily];
        testDailies[i].dailyName = [NSString stringWithFormat:@"daily %d",i];
        [SHData insertIntoContext:testDailies[i]];
        NSDate *dailyDate = nil;
        if(i%10 == 0){
            //before
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:5 minute:0 second:0];
            a0++;
        }
        else if(i%9 == 0){
            //on
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:6 minute:0 second:0];
            a1++;
        }
        else if(i%8 == 0){
            //after
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:7 minute:0 second:0];
            a2++;
        }
        else if(i%7 == 0){
            //after next actual day
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:2 minute:0 second:0];
            a3++;
        }
        else if(i%6 == 0){
            //after after
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:8 minute:0 second:0];
            a4++;
        }
        else if(i%5 == 0){
            //before before
            dailyDate = [NSDate createDateTimeWithYear:1988 month:4 day:26 hour:8 minute:0 second:0];
            a5++;
        }
        testDailies[i].lastActivationTime = dailyDate;
        testDailies[i].isActive = YES;
    }
    [SHData saveAndWait];
    
    //sanity check
    XCTAssertEqual((a0+a1+a2+a3+a4+a5), 27);
}

-(void)tearDown {
    testDailies = nil;
    [super tearDown];
}

-(void)testGetAnything{
    NSFetchedResultsController* resultsController = [SHData getItemFetcher:Daily.fetchRequest predicate:nil sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"urgency" ascending:NO]]];
    NSError *error;
    if(![resultsController performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    XCTAssertEqual(resultsController.fetchedObjects.count,50);
}

-(void)testRetrieveUnfinishedDailies{
    
    NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:6 minute:0 second:0];
    NSFetchedResultsController *results = [Daily getUnfinishedDailiesController:testDate];
    NSFetchedResultsController *results2 = [Daily getFinishedDailiesController:testDate];
    NSError *error;
    if(![results performFetch:&error]){
        
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    if(![results2 performFetch:&error]){
        
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    XCTAssertEqual(results.fetchedObjects.count,31);
    XCTAssertEqual(results2.fetchedObjects.count,19);
    //add save new item
    Daily *d = [Daily constructDaily];
    d.dailyName = @"addedDaily";
    [SHData insertIntoContext:d];
    //after insert, before fetch
    XCTAssertEqual(results.fetchedObjects.count,31);
    XCTAssertEqual(results2.fetchedObjects.count,19);
    
    if(![results performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    if(![results2 performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    //after insert, after fetch, before save
    XCTAssertEqual(results.fetchedObjects.count,32);
    XCTAssertEqual(results2.fetchedObjects.count,19);
    //saving is unecessary to be included in fetch results
    
    NSManagedObjectContext *prevContext = SHData.inUseContext;
    SHData.inUseContext = [SHData constructContext:NSMainQueueConcurrencyType];
    Daily *d2 = [Daily constructDaily];
    d2.dailyName = @"addedDaily2";
    [SHData insertIntoContext:d2];
    [SHData saveAndWait];
    SHData.inUseContext = prevContext;
    
    if(![results performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    if(![results2 performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    XCTAssertEqual(results.fetchedObjects.count,33);
    XCTAssertEqual(results2.fetchedObjects.count,19);
}

//-(void)testCalculateNextDueTime{
//    NSDate *checkinTime = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:11 minute:15 second:30 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
//    //is due next day at 12AM
//    NSDate *nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:1 andDayStart:0];
//    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578203200);
//    //is due next day at 6AM
//    nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:1 andDayStart:6];
//    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578224800);
//    //2 days later at 2PM
//    nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:2 andDayStart:14];
//    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578340000);
//}

-(void)testDaysUntilDue{
    Daily *d = [Daily constructDaily];
    d.lastActivationTime = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:24 second:11 timeZone: [NSTimeZone timeZoneWithName:@"America/New_York"]];
    //if the rate is one, it should always result in being 0 days until Daily is due
    d.rate = 1;
    SHSettings.dayStart = 0;
    testTodayReplacement = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:9 minute:24 second:11 timeZone: [NSTimeZone timeZoneWithName:@"America/New_York"]];
    XCTAssertEqual(d.daysUntilDue,0);
    d.rate = 2;
    XCTAssertEqual(d.daysUntilDue,1);
    d.rate = 7;
    XCTAssertEqual(d.daysUntilDue,6);
}


-(void)testBuildWeek{
    BOOL testSet[] = {1,0,0,0,0,0,0};//sunday
    NSArray<RateValueItemDict *> *results = [Daily buildWeek:testSet scaler:1];
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,7);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,7);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,6);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,1);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,5);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,2);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,4);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,3);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,3);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,4);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,2);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,5);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,6);
    
    results = [Daily buildWeek:testSet scaler:4];
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,28);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,28);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,27);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,1);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,26);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,2);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,25);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,3);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,24);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,4);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,23);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,5);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,22);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,6);
    
    testSet[0] = NO;
    testSet[1] = YES; //monday
    testSet[3] = YES; //wednesday
    results = [Daily buildWeek:testSet scaler:1];
    
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,4);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,2);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,5);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,1);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,5);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,2);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,4);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,1);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,3);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,2);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,2);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,3);
    
    results = [Daily buildWeek:testSet scaler:7];
    
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,46);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,2);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,47);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,1);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,47);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,2);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,46);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,1);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,45);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,2);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,44);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,3);
    
    for(int i = 0;i<SHCONST.DAYS_IN_WEEK;i++){
        testSet[i] = YES;
    }
    results = [Daily buildWeek:testSet scaler:1];
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,1);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,1);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,1);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,1);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,1);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,1);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,1);
    
    results = [Daily buildWeek:testSet scaler:3];
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,15);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,1);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,1);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,1);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,1);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,1);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,15);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,1);
    
    testSet[4] = NO;
    results = [Daily buildWeek:testSet scaler:3];
    //sunday
    XCTAssertEqual(results[0][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[0][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[0][BACKRANGE_KEY].integerValue,15);
    
    //monday
    XCTAssertEqual(results[1][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[1][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[1][BACKRANGE_KEY].integerValue,1);
    
    //tuesday
    XCTAssertEqual(results[2][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[2][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[2][BACKRANGE_KEY].integerValue,1);
    
    //wednesday
    XCTAssertEqual(results[3][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[3][FORRANGE_KEY].integerValue,2);
    XCTAssertEqual(results[3][BACKRANGE_KEY].integerValue,1);
    
    //thurday
    XCTAssertEqual(results[4][IS_DAY_ACTIVE_KEY].boolValue,NO);
    XCTAssertEqual(results[4][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[4][BACKRANGE_KEY].integerValue,1);
    
    //friday
    XCTAssertEqual(results[5][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[5][FORRANGE_KEY].integerValue,1);
    XCTAssertEqual(results[5][BACKRANGE_KEY].integerValue,2);
    
    //saturday
    XCTAssertEqual(results[6][IS_DAY_ACTIVE_KEY].boolValue,YES);
    XCTAssertEqual(results[6][FORRANGE_KEY].integerValue,15);
    XCTAssertEqual(results[6][BACKRANGE_KEY].integerValue,1);
}

//TODO: test hourly difference and think about the case where the user changes their start up time
//I don't think the scaler stuff comes into play yet
-(void)testPreviousDate{
    BOOL testSet[] = {0,1,0,1,0,0,0};//monday, wednesday
    int weekScaler = 3;
    NSArray<RateValueItemDict *> *week = [Daily buildWeek:testSet scaler:weekScaler];
    NSDate *base = [NSDate createSimpleDateWithYear:2018 month:1 day:7];
    
    NSDate *lastDueDate = [base dateAfterYears:0 months:0 days:1];
    NSDate *checkinDate = [base dateAfterYears:0 months:0 days:81];
    NSDate *result = [Daily previousDueTime_WEEKLY:lastDueDate checkinTime:checkinDate week:week weekScaler:weekScaler];
    NSDate *expectedDate = [base dateAfterYears:0 months:0 days:66];
    XCTAssertEqual(result.timeIntervalSince1970,expectedDate.timeIntervalSince1970);
    
    checkinDate = [base dateAfterYears:0 months:0 days:65];
    result = [Daily previousDueTime_WEEKLY:lastDueDate checkinTime:checkinDate week:week weekScaler:weekScaler];
    expectedDate = [base dateAfterYears:0 months:0 days:64];
    XCTAssertEqual(result.timeIntervalSince1970,expectedDate.timeIntervalSince1970);
    
}

@end
