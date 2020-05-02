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
@import SHSpecial_C;

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
	/*
		FEB
							*		*		*				*
			SU	MO	TU	WE	TH	FR	SA
															01
			02	03	04	05	06	07	08
			09	10	11	12	13	14	15
			16	17	18	19	20	21	22
			23	24	25	26	27	28	29
		MAR
			01	02	03	04	05	06	07
			08	09	10	11	12	13	14
			15	16	17	18	19	20	21
			22	23	24	25	26	27	28
			29	30	31
		
	*/
	SHDailyActiveDays *activeDays = [self.activeDaysProvider tuesWedThursSat];
	struct SHDatetime testDate = {.year = 2020, .month = 3, .day = 8};
	struct SHDueDateWeeklyContext testContext = {0};
	struct SHWeekIntervalPointList points = [activeDays.weeklyActiveDays copyWeek];
	testContext.intervalPoints = &points;
	testContext.intervalSize = activeDays.weeklyActiveDays.intervalSize;
	struct SHDatetime backupDate;
	SHErrorCode status = SH_findBackupDateForUseDate(&testDate,
		&testContext, &backupDate);
	XCTAssertEqual(status, SH_NO_ERROR);
	struct SHDatetime expected = {.year = 2020, .month = 3, .day = 7};
	double backuptTimestamp = 0;
	double expectedTimestamp = -1;
	SH_dtToTimestamp(&backupDate, &backuptTimestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	
	XCTAssertEqual(backuptTimestamp, expectedTimestamp);
	testContext.intervalSize = 3;
	SH_dtSetMonth(&expected, 2);
	SH_dtSetDay(&expected, 29);
	status = SH_findBackupDateForUseDate(&testDate,
		&testContext, &backupDate);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&backupDate, &backuptTimestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	NSLog(@"backup: %f",backuptTimestamp);
	NSLog(@"expected: %f",expectedTimestamp);
	XCTAssertEqual(backuptTimestamp, expectedTimestamp);
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
	struct SHDueDateWeeklyContext testContext = {0};
	struct SHWeekIntervalPointList points = [activeDays.weeklyActiveDays copyWeek];
	testContext.intervalPoints = &points;
	testContext.intervalSize = activeDays.weeklyActiveDays.intervalSize;
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	testContext.prevUseDate = &contextDate;
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 12};
	bool result;
	SHErrorCode status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertTrue(result);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};

	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertTrue(result);
	
	testContext.intervalSize = 2;
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	
	testContext.intervalSize = 3;
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 27};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 8};
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	
}

@end
