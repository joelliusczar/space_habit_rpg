//
//  SHPreviousDueDateTests.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHDatetime;
@import SHSpecial_C;


@interface SHPreviousDueDateTests : XCTestCase

@end

@implementation SHPreviousDueDateTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

#warning TODO: test hourly difference and think about the case where the user changes their start up time
//I don't think the scaler stuff comes into play yet
#warning TODO: there's some test I want to do to test against going out of range past 'Base'
-(void)testPreviousDate{
	
	/*
	DEC
		SU	MO	TU	WE	TH	FR	SA
												01	02
		03	04	05	06	07	08	09
		10	11	12	13	14	15	16
		17	18	19	20	21	22	23
		24	25	26	27	28	29	30
		31
	JAN
		SU	MO	TU	WE	TH	FR	SA
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

	struct SHDatetime base = {.year = 2018, .month = 1, .day = 7};
	struct SHDatetime lastDueDate = base;
	struct SHDatetime useDate = base;
	struct SHDatetime expectedDate = base;
	struct SHDatetime result;
	SHErrorCode status = SH_NO_ERROR;
	
	dueDateContext.prevUseDate = &lastDueDate;
	
	double timestamp = 0;
	double expectedTimestamp = -1;
	
	
	useDate = base;
	expectedDate = (struct SHDatetime){.year = 2017, .month = 12, .day = 20};
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	XCTAssertEqual(status, SH_ILLEGAL_INPUTS);

	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&lastDueDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 66, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 65, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 64, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 66, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 64, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 64, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 45, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 72, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 66, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 5, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 3, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 1, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 24, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 22, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 22, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 3, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 50, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 45, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	base.year = 2018;
	base.month = 1;
	base.day = 7;
	lastDueDate = base;
	
	SH_addDaysToDt(&lastDueDate, 1, SH_TIME_ADJUST_NO_OPTION);
	

	useDate = base;
	expectedDate = base;
	
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 80, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 65, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 64, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 66, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 64, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 64, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 59, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 72, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 71, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 5, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 3, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 1, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 24, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 22, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 22, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 17, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	dueDateContext.intervalPoints->days[5].isDayActive = true;
	
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 5, SH_TIME_ADJUST_NO_OPTION);
	
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 68, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 5, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 5, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 75, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 5, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[0].isDayActive = true;
	
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	//lastDueDate = base;
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 63, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 62, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 42, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 0, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	//lastDueDate = base;
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 77, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 62, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 56, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 0, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 0, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[6].isDayActive = true;
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 69, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 13, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 20, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 26, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 34, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 27, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 68, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 48, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 76, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 13, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 20, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 13, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 26, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 20, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 34, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 27, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 68, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 62, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++) {
		intervalPointList.days[i].isDayActive = true;
	}
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 69, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 13, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 20, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 34, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 27, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 68, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 67, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	SH_addDaysToDt(&useDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 2;
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 3, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 4, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 3, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	*weekScaler = 1;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 6, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 81, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 80, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 13, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 12, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 20, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 19, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 6, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 34, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 33, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	useDate = base;
	expectedDate = base;
	SH_addDaysToDt(&useDate, 68, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&expectedDate, 67, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[0].isDayActive = true;
	intervalPointList.days[1].isDayActive = true;
	*weekScaler = 3;
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	useDate = base;
	expectedDate = base;
	lastDueDate = base;
	SH_addDaysToDt(&lastDueDate, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_addDaysToDt(&useDate, 7, SH_TIME_ADJUST_NO_OPTION); //march 29
	SH_addDaysToDt(&expectedDate, 1, SH_TIME_ADJUST_NO_OPTION);
	
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);;
	SH_dtToTimestamp(&result, &timestamp);
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	XCTAssertEqual(timestamp,expectedTimestamp);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	*weekScaler = 2;
	for(int32_t i = 0; i < SH_DAYS_IN_WEEK; i++) {
		intervalPointList.days[i].isDayActive = true;
	}
	SH_refreshWeek(dueDateContext.intervalPoints, *weekScaler);
	
	lastDueDate.year = 1988;
	lastDueDate.month = 4;
	lastDueDate.day = 27;
	lastDueDate.hour = 0;
	lastDueDate.minute = 0;
	lastDueDate.second = 0;
	
	useDate.year = 1988;
	useDate.month = 4;
	useDate.day = 28;
	useDate.hour = 0;
	useDate.minute = 0;
	useDate.second = 0;
	memset(&result,0,sizeof(struct SHDatetime));
	status = SH_previousDueDate_WEEKLY(&useDate, &dueDateContext, &result);
	XCTAssertTrue(status == SH_NO_ERROR);
	
	
	lastDueDate.year = 1988;
	lastDueDate.month = 4;
	lastDueDate.day = 27;
	lastDueDate.hour = 18;
	lastDueDate.minute = 24;
	lastDueDate.second = 11;
	
	useDate.year = 1988;
	useDate.month = 4;
	useDate.day = 28;
	useDate.hour = 14;
	useDate.minute = 24;
	useDate.second = 11;
	
	status = SH_previousDueDate_WEEKLY(&useDate,&dueDateContext, &result);
	XCTAssertTrue(status == SH_NO_ERROR);
	
}

@end
