//
//  OtherDueDateFuncsTests.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHSpecial_C;

@interface OtherDueDateFuncsTests : XCTestCase

@end

@implementation OtherDueDateFuncsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testSetUseDateToLastActive {
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
	struct SHDatetime testDate = {.year = 2020, .month = 3, .day = 8};
	struct SHDatetime expected = {.year = 2020, .month = 3, .day = 7};
	
	struct SHDueDateWeeklyContext testContext = {0};
	struct SHWeekIntervalPointList intervalPointList;
	
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[2].isDayActive = true;
	intervalPointList.days[3].isDayActive = true;
	intervalPointList.days[4].isDayActive = true;
	intervalPointList.days[6].isDayActive = true;
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 1;
	testContext.weekStartOffset = 0;
	

	SHErrorCode status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	double timestamp = 0;
	double expectedTimestamp = -1;
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 2020, .month = 3, .day = 1};
	expected = (struct SHDatetime){.year = 2020, .month = 2, .day = 29};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testContext.intervalSize = 3;
	

	testDate = (struct SHDatetime){.year = 2020, .month = 3, .day = 8};
	expected = (struct SHDatetime){.year = 2020, .month = 2, .day = 22};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 2020, .month = 3, .day = 1};
	expected = (struct SHDatetime){.year = 2020, .month = 2, .day = 15};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testContext.intervalSize = 1;
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[2].isDayActive = true;
	intervalPointList.days[3].isDayActive = true;
	
	testDate = (struct SHDatetime){.year = 2020, .month = 3, .day = 1};;
	expected = (struct SHDatetime){.year = 2020, .month = 2, .day = 26};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testContext.intervalSize = 3;
	
	testDate = (struct SHDatetime){.year = 2020, .month = 3, .day = 1};;
	expected = (struct SHDatetime){.year = 2020, .month = 2, .day = 12};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testContext.intervalSize = 2;
	memset(&intervalPointList, 0, sizeof(struct SHWeekIntervalPointList));
	intervalPointList.days[2].isDayActive = true; //tues
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thur
	intervalPointList.days[6].isDayActive = true; //sat
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14};;
	expected = (struct SHDatetime){.year = 2018, .month = 1, .day = 6};
	status = SH_setUseDateToLastActive(&testDate, &testContext);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&testDate, &timestamp);
	SH_dtToTimestamp(&expected, &expectedTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(timestamp, expectedTimestamp);
	

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
	intervalPointList.days[2].isDayActive = true; //tues
	intervalPointList.days[3].isDayActive = true; //wed
	intervalPointList.days[4].isDayActive = true; //thur
	intervalPointList.days[6].isDayActive = true; //sat
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 1;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 12};
	
	bool result;
	
	testContext.prevUseDate = &contextDate;
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
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	
	testContext.intervalSize = 3;
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 25};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 28};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 2};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 8};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 13};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 21};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertTrue(result);
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 27};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	
	//switch to non due day. Should behave the same
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 8};
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 16};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 26};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(!result);
	XCTAssertEqual(status, SH_NO_ERROR);
	testDate = (struct SHDatetime){.year = 2018, .month = 3, .day = 15};
	status = SH_isWeekActiveForDate(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	
}

@end
