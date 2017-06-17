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

@interface DailyHelperTest : FrequentCase

@end

NSMutableArray<Daily *> *testDailies = nil;

@implementation DailyHelperTest

-(void)setUp {
    [super setUp];
    testDailies = [NSMutableArray array];
    int a0=0,a1=0,a2=0,a3=0,a4=0,a5=0;
    for(int i = 0;i<50;i++){
        testDailies[i] = [Daily constructDaily];
        testDailies[i].dailyName = [NSString stringWithFormat:@"daily %d",i];
        [SHData insertIntoContext:testDailies[i]];
        NSDate *dailyDate = nil;
        if(i%10 == 0){
            //before
            dailyDate = [NSDate createDateTime:1988 month:4 day:27 hour:5 minute:0 second:0];
            a0++;
        }
        else if(i%9 == 0){
            //on
            dailyDate = [NSDate createDateTime:1988 month:4 day:27 hour:6 minute:0 second:0];
            a1++;
        }
        else if(i%8 == 0){
            //after
            dailyDate = [NSDate createDateTime:1988 month:4 day:27 hour:7 minute:0 second:0];
            a2++;
        }
        else if(i%7 == 0){
            //after next actual day
            dailyDate = [NSDate createDateTime:1988 month:4 day:28 hour:2 minute:0 second:0];
            a3++;
        }
        else if(i%6 == 0){
            //after after
            dailyDate = [NSDate createDateTime:1988 month:4 day:28 hour:8 minute:0 second:0];
            a4++;
        }
        else if(i%5 == 0){
            //before before
            dailyDate = [NSDate createDateTime:1988 month:4 day:26 hour:8 minute:0 second:0];
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
    
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:6 minute:0 second:0];
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

-(void)testCalculateNextDueTime{
    NSDate *checkinTime = [NSDate createDateTime:1988 month:4 day:27 hour:11 minute:15 second:30 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    //is due next day at 12AM
    NSDate *nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:1 andDayStart:0];
    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578203200);
    //is due next day at 6AM
    nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:1 andDayStart:6];
    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578224800);
    //2 days later at 2PM
    nextDueTime = [Daily calculateNextDueTime:checkinTime withRate:2 andDayStart:14];
    XCTAssertEqual(nextDueTime.timeIntervalSince1970,578340000);
}


@end
