//
//  DateHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHModels/SingletonCluster+Entity.h>
#import "NSDate+testReplace.h"
#import <SHCommon/NSLocale+Helper.h>
@import TestCommon;

@interface DateHelperTest : FrequentCase

@end

@implementation DateHelperTest

- (void)setUp {
    [super setUp];
    [SharedGlobal setTimeZoneCascade:[NSTimeZone timeZoneWithAbbreviation:@"EST"]];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


-(void)testCreateDate{
    NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
    XCTAssertEqual(testDate.timeIntervalSince1970, 578165712);
}


-(void)testAdjustDateYear{
    NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [testDate dateAfterYears:9 months:0 days:0];
    XCTAssertEqual(result.timeIntervalSince1970, 862162512);
    result = [testDate dateAfterYears:-8 months:0 days:0];
    XCTAssertEqual(result.timeIntervalSince1970, 325704912);
}


-(void)testAdjustDateMonth{
    NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:16 hour:13 minute:35 second:12];
    NSDate *result = [testDate dateAfterYears:0 months:2 days:0];
    XCTAssertEqual(result.timeIntervalSince1970, 582485712);
    result = [testDate dateAfterYears:0 months:9 days:0];
    XCTAssertEqual(result.timeIntervalSince1970, 600978912);
    
}


-(void)testAdjustDateDay{
//test simple adding
    NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
    NSDate *result = [testDate dateAfterYears:0 months:0 days:2];
    XCTAssertEqual(result.timeIntervalSince1970, 578338512);
//test rollover to next month
    result = [testDate dateAfterYears:0 months:0 days:4];
    XCTAssertEqual(result.timeIntervalSince1970, 578511312);
//test rollover to next year during a leap year
    result = [testDate dateAfterYears:0 months:0 days:249];
    XCTAssertEqual(result.timeIntervalSince1970, 599682912);
//test rollover from febuary during leap year
    testDate = [NSDate createDateTimeWithYear:1988 month:2 day:28 hour:13 minute:35 second:12];
    result = [testDate dateAfterYears:0 months:0 days:1];
    XCTAssertEqual(result.timeIntervalSince1970, 573158112);
    result = [testDate dateAfterYears:0 months:0 days:2];
    XCTAssertEqual(result.timeIntervalSince1970, 573244512);
//test rollover from febuary during non leap year
    testDate = [NSDate createDateTimeWithYear:1989 month:2 day:28 hour:13 minute:35 second:12];
    result = [testDate dateAfterYears:0 months:0 days:2];
    XCTAssertEqual(result.timeIntervalSince1970, 604866912);
}


-(void)testGetDaysLeft{
    NSDate *fromTime = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:0 minute:0 second:0];
    NSDate *toTime = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:0 minute:0 second:0];
    int daysLeft = (int)[NSDate daysBetween:fromTime to:toTime];
    XCTAssertEqual(daysLeft,1);
}


-(void)testSwizzleDate{
    testTodayReplacement = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:45 second:40 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    [NSDate swizzleThatShit];
    NSDate *testDate = [NSDate date];
    XCTAssertEqual(testDate.timeIntervalSince1970,testTodayReplacement.timeIntervalSince1970);
    
}


-(void)testCreateSimpleTime{
    NSDate *testDate = [NSDate createSimpleTimeWithHour:2 minute:0 second:0];
    XCTAssertEqual(testDate.timeIntervalSince1970,25200);
}


-(void)testTimeOfDayInPreferredFormat{
    NSString *result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
    XCTAssertTrue([result isEqualToString:@"1:15 PM"]);
    SharedGlobal.inUseLocale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
    result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
    XCTAssertTrue([result isEqualToString:@"13:15"]);
}


-(void)testHourInFormat{
    //0-23
    NSLocale *testLocale =
    [NSLocale localeWithLocaleIdentifier:@"de_DE"];//HH 'Uhr'
    NSInteger result = [testLocale hourInLocaleFormat:0];
    XCTAssertEqual(result,0);
    result = [testLocale hourInLocaleFormat:1];
    XCTAssertEqual(result,1);
    result = [testLocale hourInLocaleFormat:11];
    XCTAssertEqual(result,11);
    result = [testLocale hourInLocaleFormat:12];
    XCTAssertEqual(result,12);
    result = [testLocale hourInLocaleFormat:22];
    XCTAssertEqual(result,22);
    result = [testLocale hourInLocaleFormat:23];
    XCTAssertEqual(result,23);
    XCTAssertThrows([testLocale hourInLocaleFormat:24]);
    
    //1-24
    NSInteger formatMask = [NSLocale hourMaskForGivenFormat:@"k"];
    result = [NSLocale hour:0 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,1);
    result = [NSLocale hour:1 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,2);
    result = [NSLocale hour:11 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,12);
    result = [NSLocale hour:12 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,13);
    result = [NSLocale hour:22 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,23);
    result = [NSLocale hour:23 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,24);
    XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
    
    //0-11
    formatMask = [NSLocale hourMaskForGivenFormat:@"K"];
    result = [NSLocale hour:0 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,0);
    result = [NSLocale hour:1 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,1);
    result = [NSLocale hour:11 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,11);
    result = [NSLocale hour:12 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,0);
    result = [NSLocale hour:13 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,1);
    result = [NSLocale hour:14 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,2);
    result = [NSLocale hour:22 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,10);
    result = [NSLocale hour:23 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,11);
    XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
    
    //1-12
    formatMask = [NSLocale hourMaskForGivenFormat:@"h"];
    result = [NSLocale hour:0 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,12);
    result = [NSLocale hour:1 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,1);
    result = [NSLocale hour:11 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,11);
    result = [NSLocale hour:12 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,12);
    result = [NSLocale hour:13 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,1);
    result = [NSLocale hour:14 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,2);
    result = [NSLocale hour:22 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,10);
    result = [NSLocale hour:23 inGivenFormatMask:formatMask];
    XCTAssertEqual(result,11);
    XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
}


NSInteger calcDaysBetween(NSInteger span){
    NSDate *base = [NSDate createSimpleDateWithYear:2017 month:1 day:7];
    NSDate *adjusted = [base dateAfterYears:0 months:0 days:span];
    NSInteger result = [NSDate daysBetween:base to:adjusted];
    return result;
}

-(void)testDaysBetween{
    XCTAssertEqual(calcDaysBetween(1),1);
    XCTAssertEqual(calcDaysBetween(2),2);
    XCTAssertEqual(calcDaysBetween(3),3);
    XCTAssertEqual(calcDaysBetween(4),4);
    XCTAssertEqual(calcDaysBetween(10),10);
    XCTAssertEqual(calcDaysBetween(11),11);
    XCTAssertEqual(calcDaysBetween(20),20);
    XCTAssertEqual(calcDaysBetween(30),30);
    XCTAssertEqual(calcDaysBetween(60),60);
    XCTAssertEqual(calcDaysBetween(61),61);
    XCTAssertEqual(calcDaysBetween(63),63);
    XCTAssertEqual(calcDaysBetween(64),64);
    XCTAssertEqual(calcDaysBetween(65),65);
    XCTAssertEqual(calcDaysBetween(66),66);
    XCTAssertEqual(calcDaysBetween(80),80);
    XCTAssertEqual(calcDaysBetween(81),81);
    XCTAssertEqual(calcDaysBetween(100),100);
    XCTAssertEqual(calcDaysBetween(1000),1000);
    XCTAssertEqual(calcDaysBetween(10000),10000);
}

-(void)testGetDayOfWeek{
    //time zone is GMT
    NSDate *testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:7];
    NSInteger result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,0);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:8];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,1);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:9];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,2);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:10];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,3);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:11];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,4);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,5);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:13];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,6);
    
    testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:14];
    result = [testDate getWeekdayIndex];
    XCTAssertEqual(result,0);
}

@end
