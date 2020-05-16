//
//  SHNextDueDateTests.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHDatetime;
@import SHSpecial_C;

@interface SHNextDueDateTests : XCTestCase

@end

@implementation SHNextDueDateTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testDueDates2{
	struct SHDueDateWeeklyContext dueDateContext;
	struct SHWeekIntervalPointList intervalPointList;
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[1].isDayActive = true;
	dueDateContext.dayStartHour = 0;
	dueDateContext.intervalPoints = &intervalPointList;
	dueDateContext.intervalSize = 1;
	dueDateContext.weekStartOffset = 0;
	
	intervalPointList.days[1].isDayActive = true;
	int32_t *weekScaler = &dueDateContext.intervalSize;
	SHErrorCode status = SH_NO_ERROR;
	
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);;
	struct SHDatetime base = {.year = 1978, .month = 1, .day = 1,};
	struct SHDatetime lastDueDate = base;
	struct SHDatetime useDate = base;
	struct SHDatetime expected = base;
	struct SHDatetime result;
	
	dueDateContext.savedPrevDate = &lastDueDate;

	SH_addDaysToDt(&lastDueDate, 0, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 0, SH_TIME_ADJUST_NO_OPTION);
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	XCTAssertEqual(status,SH_INVALID_STATE);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[0].isDayActive = true;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	base.year = 2006;
	useDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&lastDueDate, 0, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	XCTAssertEqual(status,SH_NO_ERROR);
	
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	SH_addDaysToDt(&useDate, 0, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&lastDueDate, 0, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	XCTAssertEqual(status,SH_NO_ERROR);
}


-(void)testNextDueDateWeekly{

	struct SHDatetime base = {.year = 2018, .month = 1, .day = 7};
	struct SHDatetime lastDueDate = base;
	struct SHDatetime useDate = base;
	struct SHDatetime expected = base;
	struct SHDatetime result;

	struct SHDueDateWeeklyContext dueDateContext;
	struct SHWeekIntervalPointList intervalPointList;
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[1].isDayActive = true;
	intervalPointList.days[3].isDayActive = true;
	dueDateContext.dayStartHour = 0;
	dueDateContext.intervalPoints = &intervalPointList;
	dueDateContext.intervalSize = 3;
	dueDateContext.weekStartOffset = 0;
	dueDateContext.savedPrevDate = &lastDueDate;
	
	int32_t *weekScaler = &dueDateContext.intervalSize;
	
	SHErrorCode status = SH_NO_ERROR;
	double timestamp = 0;
	double expectedTimestamp = -1;
	
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	SH_addDaysToDt(&lastDueDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expected, 85, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 65, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 66, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 63, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 62, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 50, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 46, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 66, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 66, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 64, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 62, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 63, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 64, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 64, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 65, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 66, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 66, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 66, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 67, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 71, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 68, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 71, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 69, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 71, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 70, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 71, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 71, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 71, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 72, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 73, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 73, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 73, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	useDate = base;
	expected = base;
	SH_addDaysToDt(&useDate, 74, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expected, 78, SH_TIME_ADJUST_NO_OPTION);
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[0].isDayActive = true;
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	
}


-(void)testNextDueDateDiffTimezone {
	/*
	#calendar 2018
	DEC
		SU	MO	TU	WE	TH	FR	SA
												01	02
		03	04	05	06	07	08	09
		10	11	12	13	14	15	16
		17	18	19	20	21	22	23
		24	25	26	27	28	29	30
		31
	JAN
				01	02	03	04	05	06
		07	08	09	10	11	12	13*
		14	15	16	17	18	19	20
		21	22	23	24	25	26	27
		28	29	30	31
	*/
	
	struct SHDueDateWeeklyContext dueDateContext;
	struct SHWeekIntervalPointList intervalPointList;
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[1].isDayActive = true;
	intervalPointList.days[3].isDayActive = true;
	dueDateContext.dayStartHour = 0;
	dueDateContext.intervalPoints = &intervalPointList;
	dueDateContext.intervalSize = 3;
	dueDateContext.weekStartOffset = 0;
	
	int32_t *weekScaler = &dueDateContext.intervalSize;
	
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);

	struct SHDatetime lastDueDate = {.year = 2018, .month = 1, .day = 8, .timezoneOffset = -18000 };
	struct SHDatetime useDate = {.year = 2018, .month = 1, .day = 17, .timezoneOffset = -36000 };
	struct SHDatetime expectedDate = {.year = 2018, .month = 1, .day = 29, .timezoneOffset = -36000  };
	struct SHDatetime result;
	SHErrorCode status = SH_NO_ERROR;
	
	dueDateContext.savedPrevDate = &lastDueDate;
	
	double timestamp = 0;
	double expectedTimestamp = -1;
	
	status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
}

@end
