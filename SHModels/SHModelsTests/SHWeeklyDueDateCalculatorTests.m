//
//  SHWeeklyDueDateCalculatorTests.m
//  SHModelsTests
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHDailyNextWeeklyDueDateCalculator.h"
@import SHTestCommon;

@interface SHWeeklyDueDateCalculatorTests : FrequentCase
@property (strong, nonatomic, nonnull) SHActiveDaysProvider *activeDaysProvider;
@end

@implementation SHWeeklyDueDateCalculatorTests

-(void)setUp {
		self.activeDaysProvider = [[SHActiveDaysProvider alloc] init];
		// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testTuesWedThursSat {
	SHDailyActiveDays *activeDays = [self.activeDaysProvider tuesWedThursSat];
	
	SHDailyNextDueDateCalculator *calc = [SHDailyNextDueDateCalculator
		newWithActiveDays:activeDays intervalType:SH_WEEKLY_RATE];
	calc.dayStartTime = 0;
	calc.lastActivationDateTime = nil;
	calc.lastUpdateDateTime = [NSDate createDateTimeWithYear:2020
		month:3
		day:8
		hour:0
		minute:0
		second:0];
		
	NSDate *backupDate = [calc calcBackupLastCheckinDate];
	NSDate *expected = [NSDate createDateTimeWithYear:2020
		month:3
		day:7
		hour:0
		minute:0
		second:0];
	XCTAssertEqual(backupDate.timeIntervalSince1970, expected.timeIntervalSince1970);
	activeDays.weeklyActiveDays.intervalSize = 3;
	backupDate = [calc calcBackupLastCheckinDate];
	expected = [NSDate createDateTimeWithYear:2020
	month:2
	day:29
	hour:0
	minute:0
	second:0];
}


-(void)testIsWeekActive {
	/*
			SU	MO	TU	WE	TH	FR	SA
													01	02
			03	04	05	06	07	08	09		2	3
			10	11	12	13	14	15	16
			17	18	19	20	21	22	23		2
			24	25	26	27	28	29	30			3
			31														2
					01	02	03	04	05	06
			07	08	09	10	11	12	13	*
			14	15	16	17	18	19	20	1
			21	22	23	24	25	26	27	1	2
			28	29	30	31
		FEB
											01	02	03	1		3
			04	05	06	07	08	09	10	1	2
			11	12	13	14	15	16	17	1
			18	19	20	21	22	23	24	1	2	3
			25	26	27	28							1
		MAR
											01	02	03		2
			04	05	06	07	08	09	10
			11	12	13	14	15	16	17		2	3
			18	19	20	21	22	23	24
			25	26	27	28	29	30	31		2
	*/
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	SHDailyActiveDays *activeDays = [self.activeDaysProvider tuesWedThursSat];
	SHDailyNextWeeklyDueDateCalculator *calc = [[SHDailyNextWeeklyDueDateCalculator alloc]
		initWithRateItemList: activeDays.weeklyActiveDays];
	calc.dayStartTime = 0;
	calc.lastActivationDateTime = nil;
	calc.lastUpdateDateTime = [NSDate createSimpleDateWithYear:2018 month:1 day:10];
	calc.activeDays.intervalSize = 1;
	NSDate *testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	BOOL result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:16];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	
	calc.activeDays.intervalSize = 2;
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:16];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:25];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:28];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	
	calc.activeDays.intervalSize = 3;
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:16];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:25];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:28];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:31];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:2 day:2];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:2 day:8];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:2 day:13];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:2 day:21];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:2 day:27];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	
	calc.lastUpdateDateTime = [NSDate createSimpleDateWithYear:2018 month:1 day:8];
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:11];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:16];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:26];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(!result);
	testDate = [NSDate createSimpleDateWithYear:2018 month:3 day:15];
	result = [calc isWeekActiveForDate:testDate];
	XCTAssertTrue(result);
	
}

@end
