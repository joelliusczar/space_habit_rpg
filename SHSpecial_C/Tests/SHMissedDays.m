//
//  SHMissedDays.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <stdbool.h>
@import SHSpecial_C;

@interface SHMissedDays : XCTestCase

@end

@implementation SHMissedDays

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testMissedDays {
	/*
		#calendar 2018
			SU	MO	TU	WE	TH	FR	SA
													01	02
			03	04	05	06	07	08	09		2	3
			10	11	12	13	14	15	16
			17	18	19	20	21	22	23		2
			24	25	26	27	28	29	30			3
			31														2
		JAN
					01	02	03	04	05	06
			07	08	09	10	11	12	13	*
			14	15	16	17	18	19	20	1
			21	22	23	24	25	26	27	1	2
			28	29	30	31									3
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
	
	struct SHDueDateWeeklyContext testContext;
	struct SHWeekIntervalPointList intervalPointList;
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	
	intervalPointList.days[1].isDayActive = true; //mon
	intervalPointList.days[3].isDayActive = true; //wed
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 1;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	
	
	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;
	
	testContext.savedPrevDate = &contextDate;
	
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
	testContext.intervalSize = 2;
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);
	
	testContext.intervalSize = 3;
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	
	intervalPointList.days[0].isDayActive = true; //sun
	intervalPointList.days[1].isDayActive = true; //mon
	intervalPointList.days[2].isDayActive = true; //tue
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thr
	intervalPointList.days[5].isDayActive = true; //fri
	intervalPointList.days[6].isDayActive = true; //sat
	
	testContext.intervalSize = 1;
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 22);
	
	testContext.intervalSize = 2;
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 8);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 9);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	//sun *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);
	
	//mon *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 11);
	
	//tues *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 12);
	
	//wed *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 13);
	
	//thr *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 14);
	
	//fri *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 15);
	
	
	//sat *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 16);
	
	//sun
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//mon
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//tue
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//wed
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//thr
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//fri
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//sat
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//sun *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);
	
	//mon *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 18);
	
	//tue *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 19);
	
	//wed *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 20);
	
	//thr *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 21);
	
	//fri *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 22);
	
	//sat *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 23);
	
	//sun
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);
	
	//mon
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);
}


-(void)testMissedDaysAllActiveDaysInterval3 {
	struct SHDueDateWeeklyContext testContext;
	struct SHWeekIntervalPointList intervalPointList;
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	
	intervalPointList.days[0].isDayActive = true; //sun
	intervalPointList.days[1].isDayActive = true; //mon
	intervalPointList.days[2].isDayActive = true; //tue
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thr
	intervalPointList.days[5].isDayActive = true; //fri
	intervalPointList.days[6].isDayActive = true; //sat
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 3;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	
	
	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;
	
	testContext.savedPrevDate = &contextDate;
	
	//Wednesday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Friday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Saturday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Tuesday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Wednesday *
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);

	
	//Thursday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);

	
	//Friday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 8);

	
	//Saturday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 9);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Sunday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 11);

	
	//Tuesday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 12);

	
	//Wednesday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 13);

	
	//Thursday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 14);

	
	//Friday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 15);

	
	//Saturday *
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 16);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Sunday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 18);

		
	//Tuesday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 19);

	
	//Wednesday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 20);

	
	//Thursday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 21);

	
	//Friday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 22);

	
	//Saturday*
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 23);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);


	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Sunday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 25);

	
	//Tuesday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 26);

	
	//Wednesday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 27);

	
	//Thursday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 28);

	
	//Friday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 29);

	
	//Saturday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 30);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Sunday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Monday*
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 32);

}


-(void)testMissedDaysOneActiveDayInterval3 {
	struct SHDueDateWeeklyContext testContext;
	struct SHWeekIntervalPointList intervalPointList;
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	
	intervalPointList.days[3].isDayActive = true; //wed

	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 3;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	
	
	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;
	
	testContext.savedPrevDate = &contextDate;
	
		//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);


	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
}

-(void)testMissedDaysAllActiveDaysInterval4 {
	/*
		#calendar 2018
			SU	MO	TU	WE	TH	FR	SA
													01	02
			03	04	05	06	07	08	09
			10	11	12	13	14	15	16
			17	18	19	20	21	22	23
			24	25	26	27	28	29	30
jan		31	01	02	03	04	05	06
			07	08	09	10	11	12	13	*
			14	15	16	17	18	19	20	1
			21	22	23	24	25	26	27	1	2
feb		28	29	30	31	01	02	03	1		3
			04	05	06	07	08	09	10	1	2		4
			11	12	13	14	15	16	17	1				5
			18	19	20	21	22	23	24	1	2	3			6
mar		25	26	27	28	01	02	03	1						7
			04	05	06	07	08	09	10	1	2		4				8
			11	12	13	14	15	16	17	1		3
			18	19	20	21	22	23	24	1	2			5
			25	26	27	28	29	30	31	1
apr		01	02	03	04	05	06	07	1	2	3	4		6
			08	09	10	11	12	13	14	1
			15	16	17	18	19	20	21	1	2					7
			22	23	24	25	26	27	28	1		3		5
may		29	30	01	02	03	04	05	1	2		4				8
			06	07	08	09	10	11	12	1
			13	14	15	16	17	18	19	1	2	3			6
			20	21	22	23	24	25	26	1
jun		27	28	29	30	31  01	02	1	2		4	5
 			03	04	05	06	07	08	09	1		3				7
			10	11	12	13	14	15	16	1	2
	 		17	18	19	20	21	22	23	1
			24	25	26	27	28	29	30	1	2	3	4		6		8
jul		01	02	03	04	05	06	07	1				5
			08	09	10	11	12	13	14	1	2
			15	16	17	18	19	20	21	1		3
			22	23	24	25	26	27	28	1	2		4			7
aug		29	30	31	01	02	03	04	1
			05	06	07	08	09	10	11	1	2	3		5	6
			12	13	14	15	16	17	18	1
			19	20	21	22	23	24	25	1	2		4				8
sep		26	27	28	29	30	31	01	1		3
			02	03	04	05	06	07	08	1	2
			09	10	11	12	13	14	15	1				5		7
			16	17	18	19	20	21	22	1	2	3	4		6
			23	24	25	26	27	28	29	1
oct		30	01	02	03	04	05	06	1	2
			07	08	09	10	11	12	13	1		3
			14	15	16	17	18	19	20	1	2		4	5			8
			21	22	23	24	25	26	27	1
nov		28	29	30	31	01	02	03	1	2	3			6	7
			04	05	06	07	08	09	10	1
			11	12	13	14	15	16	17	1	2		4
			18	19	20	21	22	23	24	1		3		5
dec		25	26	27	28	29	30	01	1	2
			02	03	04	05	06	07	08	1
			09	10	11	12	13	14	15	1	2	3	4		6		8
			16	17	18	19	20	21	22	1						7
			23	24	25	26	27	28	29	1	2			5
			30	31
	*/
	struct SHDueDateWeeklyContext testContext;
	struct SHWeekIntervalPointList intervalPointList;
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	
	intervalPointList.days[0].isDayActive = true; //sun
	intervalPointList.days[1].isDayActive = true; //mon
	intervalPointList.days[2].isDayActive = true; //tue
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thr
	intervalPointList.days[5].isDayActive = true; //fri
	intervalPointList.days[6].isDayActive = true; //sat
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 4;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	
	
	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;
	
	testContext.savedPrevDate = &contextDate;

	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 8);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 9);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 10);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 11);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 12);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 13);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 14);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 15);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 16);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 31, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 17);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 18);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 19);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 20);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 21);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 22);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 23);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 14, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 15, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 16, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 17, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 18, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 19, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 20, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 21, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 24);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 4, .day = 30, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 25);

	
	//Tuesday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 1, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 26);

	
	//Wednesday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 2, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 27);

	
	//Thursday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 3, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 28);

	
	//Friday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 4, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 29);

	
	//Saturday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 5, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 30);

	
	//Sunday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 6, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
	//Monday
	testDate = (struct SHDatetime){.year = 2018, .month = 5, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 31);

	
}


-(void)testMissedDaysSavedDateLaterInWeek {
		/*
			#calendar 2018
				SU	MO	TU	WE	TH	FR	SA
														01	02
				03	04	05	06	07	08	09
				10	11	12	13	14	15	16
				17	18	19	20	21	22	23
				24	25	26	27	28	29	30
	jan		31	01	02	03	04	05	06
				07	08	09	10	11	12	13	*
				14	15	16	17	18	19	20	1
				21	22	23	24	25	26	27	1	2
	feb		28	29	30	31	01	02	03	1		3
				04	05	06	07	08	09	10	1	2		4
				11	12	13	14	15	16	17	1				5
				18	19	20	21	22	23	24	1	2	3			6
	mar		25	26	27	28	01	02	03	1						7
				04	05	06	07	08	09	10	1	2		4				8
				11	12	13	14	15	16	17	1		3
				18	19	20	21	22	23	24	1	2			5
				25	26	27	28	29	30	31	1
	apr		01	02	03	04	05	06	07	1	2	3	4		6
				08	09	10	11	12	13	14	1
				15	16	17	18	19	20	21	1	2					7
				22	23	24	25	26	27	28	1		3		5
	may		29	30	01	02	03	04	05	1	2		4				8
				06	07	08	09	10	11	12	1
				13	14	15	16	17	18	19	1	2	3			6
				20	21	22	23	24	25	26	1
	jun		27	28	29	30	31  01	02	1	2		4	5
				03	04	05	06	07	08	09	1		3				7
				10	11	12	13	14	15	16	1	2
				17	18	19	20	21	22	23	1
				24	25	26	27	28	29	30	1	2	3	4		6		8
	jul		01	02	03	04	05	06	07	1				5
				08	09	10	11	12	13	14	1	2
				15	16	17	18	19	20	21	1		3
				22	23	24	25	26	27	28	1	2		4			7
	aug		29	30	31	01	02	03	04	1
				05	06	07	08	09	10	11	1	2	3		5	6
				12	13	14	15	16	17	18	1
				19	20	21	22	23	24	25	1	2		4				8
	sep		26	27	28	29	30	31	01	1		3
				02	03	04	05	06	07	08	1	2
				09	10	11	12	13	14	15	1				5		7
				16	17	18	19	20	21	22	1	2	3	4		6
				23	24	25	26	27	28	29	1
	oct		30	01	02	03	04	05	06	1	2
				07	08	09	10	11	12	13	1		3
				14	15	16	17	18	19	20	1	2		4	5			8
				21	22	23	24	25	26	27	1
	nov		28	29	30	31	01	02	03	1	2	3			6	7
				04	05	06	07	08	09	10	1
				11	12	13	14	15	16	17	1	2		4
				18	19	20	21	22	23	24	1		3		5
	dec		25	26	27	28	29	30	01	1	2
				02	03	04	05	06	07	08	1
				09	10	11	12	13	14	15	1	2	3	4		6		8
				16	17	18	19	20	21	22	1						7
				23	24	25	26	27	28	29	1	2			5
				30	31
		*/
	struct SHDueDateWeeklyContext testContext;
	struct SHWeekIntervalPointList intervalPointList;

	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));

	intervalPointList.days[0].isDayActive = true; //sun
	intervalPointList.days[1].isDayActive = true; //mon
	intervalPointList.days[2].isDayActive = true; //tue
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thr
	intervalPointList.days[5].isDayActive = true; //fri
	intervalPointList.days[6].isDayActive = true; //sat
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 2;
	testContext.weekStartOffset = 0;

	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 13};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 21, .timezoneOffset = -18000};


	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;

	testContext.savedPrevDate = &contextDate;
	
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 9};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 8};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 7};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 6};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12};
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 22, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 23, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 24, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 27, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 7);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 8);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 29, .timezoneOffset = -18000};
	status = SH_missedDays_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(result, 8);
}
@end
