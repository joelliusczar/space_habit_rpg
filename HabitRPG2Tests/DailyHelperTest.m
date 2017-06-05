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
    NSError *error;
    if(![results performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    XCTAssertEqual(results.fetchedObjects.count,31);
    //add save new item
    Daily *d = [Daily constructDaily];
    d.dailyName = @"addedDaily";
    [SHData insertIntoContext:d];
    //after insert, before fetch
    XCTAssertEqual(results.fetchedObjects.count,31);
    
    if(![results performFetch:&error]){
        NSLog(@"Error fetching data: %@", error.localizedFailureReason);
        XCTAssertNil(error);
    }
    //after insert, after fetch, before save
    XCTAssertEqual(results.fetchedObjects.count,32);
    //saving is unecessary to be included in fetch results
    
}



@end
