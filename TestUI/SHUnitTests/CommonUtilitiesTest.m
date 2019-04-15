//
//  CommonUtilitiesTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/SingletonCluster.h>
#import <SHGlobal/Constants.h>
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHModels/ModelTools.h>
#import <SHCommon/CommonUtilities.h>


@interface CommonUtilitiesTest : XCTestCase

@end


static BOOL shouldUseLowerBound =YES;
static uint (*ogRandFn)(uint);

uint mockRandom(uint bound){
    return shouldUseLowerBound?0:(bound-1);
}


@implementation CommonUtilitiesTest

NSDate* getReferenceDate(){
    NSCalendar *cal = NSCalendar.currentCalendar;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 2016;
    dateComponents.month = 1;
    dateComponents.day = 1;
    dateComponents.hour = 0;
    dateComponents.minute = 0;
    dateComponents.second = 0;
    
    return [cal dateFromComponents:dateComponents];
}

    
- (void)setUp {
    [super setUp];
    ogRandFn = randomUInt;
    randomUInt = &mockRandom;
}

-(void)testGetReferenceDate{
    NSDate *d = getReferenceDate();
    XCTAssertTrue([[d description] isEqualToString:@"2016-01-01 05:00:00 +0000"]);
}

-(void)testCalculateLvl{
    uint offset = 10;
    
    uint lvl = 0;
    shouldUseLowerBound = YES;
    int result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 11);
    lvl = 1;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 11);
    lvl = 2;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 12);
    lvl = 5;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 15);
    lvl = 9;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 19);
    lvl = 10;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 20);
    lvl = 11;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 1);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 21);
    lvl = 12;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 2);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 22);
    lvl = 15;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 5);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 25);
    lvl = 55;
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 45);
    shouldUseLowerBound = !shouldUseLowerBound;
    result = calculateLvl(lvl,offset);
    XCTAssertEqual(result, 65);
    
}

-(void)testJsonStuff{
    NSMutableDictionary *testDict = [NSMutableDictionary dictionary];
    testDict[@"SAT"] = @1;
    testDict[@"MON"] = @1;
    
    NSString *testJson = [NSMutableDictionary dictToString:testDict];
    NSMutableDictionary *testDict2 = [NSMutableDictionary jsonStringToDict:testJson];
    XCTAssertEqual(((NSNumber *)testDict2[@"SAT"]).integerValue,1);
    [testDict2 removeObjectForKey:@"MON"];
    testDict2[@"THR"] = @1;
    
    NSString *testJson2 = [NSMutableDictionary dictToString:testDict2];
    NSMutableDictionary *testDict3 = [NSMutableDictionary jsonStringToDict:testJson2];
    XCTAssertEqual(((NSNumber *)testDict3[@"THR"]).integerValue,1);
    XCTAssertNil(testDict3[@"MON"]);
    
    
}

-(void)testRandomUintF{
  uint bound = 25;
  uint result = ogRandFn(bound);
  XCTAssertTrue(result >= 0 && result <= 25);
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
