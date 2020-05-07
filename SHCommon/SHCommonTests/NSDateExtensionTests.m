//
//  NSDateExtensionTests.m
//  SHCommonTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;

@interface NSDateExtensionTests : XCTestCase

@end

@implementation NSDateExtensionTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testTimeOfDayInPreferredFormat{
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
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


-(void)testAMPMSymbol{
	NSLocale *loc = SharedGlobal.inUseLocale;
	NSString *pm = loc.PMSymbol;
	NSString *am = loc.AMSymbol;
	XCTAssertTrue([pm isEqualToString:@"PM"]);
	XCTAssertTrue([am isEqualToString:@"AM"]);
}


-(void)testGetComponents{
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	NSDate *testDate = [NSDate dateWithTimeIntervalSince1970:1588427687];
	NSDateComponents *components = [testDate getDateComponents];
	XCTAssertEqual(components.year,2020);
	XCTAssertEqual(components.month, 5);
	XCTAssertEqual(components.day, 2);
	XCTAssertEqual(components.hour,13);
	XCTAssertEqual(components.minute, 54);
	XCTAssertEqual(components.second, 47);
}

@end
