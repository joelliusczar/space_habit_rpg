//
//	DateHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+testReplace.h"
#import <XCTest/XCTest.h>
@import SHCommon;
#import <SHDatetime/SHDatetime.h>




@import SHTestCommon;

@interface DateHelperTest : FrequentCase

@end

@implementation DateHelperTest

- (void)setUp {
	[super setUp];
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:-18000];
}


- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}



-(void)testGetComponents{
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:15 minute:32 second:17];
	NSDateComponents *components = [testDate getDateComponents];
	XCTAssertEqual(components.year,1988);
	XCTAssertEqual(components.month, 4);
	XCTAssertEqual(components.day, 27);
	XCTAssertEqual(components.hour,15);
	XCTAssertEqual(components.minute, 32);
	XCTAssertEqual(components.second, 17);
}

-(void)testDayStart{
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:15 minute:32 second:17];
	NSDate *result = [testDate dayStart];
	NSDateComponents *components = [result getDateComponents];
	XCTAssertEqual(components.year,1988);
	XCTAssertEqual(components.month, 4);
	XCTAssertEqual(components.day, 27);
	XCTAssertEqual(components.hour,0);
	XCTAssertEqual(components.minute, 0);
	XCTAssertEqual(components.second, 0);
}






-(void)testGetDayOfWeekOffsetted {
	NSDate *sun = [NSDate createSimpleDateWithYear:2018 month:1 day:7];
	NSDate *mon = [NSDate createSimpleDateWithYear:2018 month:1 day:8];
	NSDate *tue = [NSDate createSimpleDateWithYear:2018 month:1 day:9];
	NSDate *wed = [NSDate createSimpleDateWithYear:2018 month:1 day:10];
	NSDate *thurs = [NSDate createSimpleDateWithYear:2018 month:1 day:11];
	NSDate *fri = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	NSDate *sat = [NSDate createSimpleDateWithYear:2018 month:1 day:13];
	NSUInteger offset = 0;
	NSUInteger result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);

	offset = 1;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	
	offset = 2;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	
	offset = 3;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	
	offset = 4;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	
	offset = 5;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	
	offset = 6;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	
	offset = 7;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
}

@end
