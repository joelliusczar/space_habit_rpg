//
//  DateHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDate+DateHelper.h"
#import "SingletonCluster.h"
#import "NSDate+testReplace.h"

@interface DateHelperTest : XCTestCase

@end

@implementation DateHelperTest

- (void)setUp {
    [super setUp];
    SharedGlobal.inUseTimeZone = [NSTimeZone timeZoneWithName:@"America/New_York"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testCreateDate{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    XCTAssertEqual(testDate.timeIntervalSince1970, 578165712);
}

-(void)testAdjustDateYear{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:9 month:0 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 862162512);
    result = [NSDate adjustDate:testDate year:-8 month:0 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 325704912);
}

-(void)testAdjustDateMonth{
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:16 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:0 month:2 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 582485712);
    result = [NSDate adjustDate:testDate year:0 month:9 day:0];
    XCTAssertEqual(result.timeIntervalSince1970, 600978912);
    
}

-(void)testAdjustDateDay{
//test simple adding
    NSDate *testDate = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 578338512);
//test rollover to next month
    result = [NSDate adjustDate:testDate year:0 month:0 day:4];
    XCTAssertEqual(result.timeIntervalSince1970, 578511312);
//test rollover to next year during a leap year
    result = [NSDate adjustDate:testDate year:0 month:0 day:249];
    XCTAssertEqual(result.timeIntervalSince1970, 599682912);
//test rollover from febuary during leap year
    testDate = [NSDate createDateTime:1988 month:2 day:28 hour:13 minute:35 second:12];
    result = [NSDate adjustDate:testDate year:0 month:0 day:1];
    XCTAssertEqual(result.timeIntervalSince1970, 573158112);
    result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 573244512);
//test rollover from febuary during non leap year
    testDate = [NSDate createDateTime:1989 month:2 day:28 hour:13 minute:35 second:12];
    result = [NSDate adjustDate:testDate year:0 month:0 day:2];
    XCTAssertEqual(result.timeIntervalSince1970, 604866912);
}

-(void)testGetDaysLeft{
    NSDate *fromTime = [NSDate createDateTime:1988 month:4 day:27 hour:0 minute:0 second:0];
    NSDate *toTime = [NSDate createDateTime:1988 month:4 day:28 hour:0 minute:0 second:0];
    int daysLeft = (int)[NSDate daysBetween:fromTime to:toTime];
    XCTAssertEqual(daysLeft,1);
}

-(void)testSwizzleDate{
    testTodayReplacement = [NSDate createDateTime:1988 month:4 day:27 hour:13 minute:45 second:40 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    [NSDate swizzleThatShit];
    NSDate *testDate = [NSDate date];
    XCTAssertEqual(testDate.timeIntervalSince1970,testTodayReplacement.timeIntervalSince1970);
    
}

@end
