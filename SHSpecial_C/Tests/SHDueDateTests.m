//
//  SHDueDateTests.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <stdbool.h>
@import SHSpecial_C;

@interface SHDueDateTests : XCTestCase

@end

@implementation SHDueDateTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testBuildWeek{
	
	struct SHWeekIntervalPointList results;
	memset(&results, 0, sizeof(struct SHWeekIntervalPointList));
	results.days[0].isDayActive = true;
	
	SH_refreshWeek(&results,1);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,7);
	XCTAssertEqual(results.days[0].backrange,7);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,false);
	XCTAssertEqual(results.days[1].forrange,6);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,5);
	XCTAssertEqual(results.days[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,false);
	XCTAssertEqual(results.days[3].forrange,4);
	XCTAssertEqual(results.days[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,3);
	XCTAssertEqual(results.days[4].backrange,4);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,2);
	XCTAssertEqual(results.days[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,1);
	XCTAssertEqual(results.days[6].backrange,6);
	
	
	SH_refreshWeek(&results,4);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,28);
	XCTAssertEqual(results.days[0].backrange,28);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,false);
	XCTAssertEqual(results.days[1].forrange,27);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,26);
	XCTAssertEqual(results.days[2].backrange,2);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,false);
	XCTAssertEqual(results.days[3].forrange,25);
	XCTAssertEqual(results.days[3].backrange,3);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,24);
	XCTAssertEqual(results.days[4].backrange,4);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,23);
	XCTAssertEqual(results.days[5].backrange,5);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,22);
	XCTAssertEqual(results.days[6].backrange,6);
	
	memset(&results, 0, sizeof(struct SHWeekIntervalPointList));
	results.days[1].isDayActive = true; //monday
	results.days[3].isDayActive = true; //wednesday
	

	SH_refreshWeek(&results,1);
	
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,false);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,4);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,2);
	XCTAssertEqual(results.days[1].backrange,5);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,5);
	XCTAssertEqual(results.days[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,4);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,3);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,2);
	XCTAssertEqual(results.days[6].backrange,3);
	
	SH_refreshWeek(&results,7);
	
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,false);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,46);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,2);
	XCTAssertEqual(results.days[1].backrange,47);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,false);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,47);
	XCTAssertEqual(results.days[3].backrange,2);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,46);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,false);
	XCTAssertEqual(results.days[5].forrange,45);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,false);
	XCTAssertEqual(results.days[6].forrange,44);
	XCTAssertEqual(results.days[6].backrange,3);
	
	
	for(int32_t i = 0;i<SH_DAYS_IN_WEEK;i++){
		results.days[i].isDayActive = true;
	}
	SH_refreshWeek(&results,1);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,1);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,1);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,true);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,1);
	XCTAssertEqual(results.days[6].backrange,1);
	
	SH_refreshWeek(&results,3);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,15);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,1);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,true);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,1);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,15);
	XCTAssertEqual(results.days[6].backrange,1);
	
	
	results.days[4].isDayActive = false;
	
	SH_refreshWeek(&results,3);
	//sunday
	XCTAssertEqual(results.days[0].isDayActive,true);
	XCTAssertEqual(results.days[0].forrange,1);
	XCTAssertEqual(results.days[0].backrange,15);
	
	//monday
	XCTAssertEqual(results.days[1].isDayActive,true);
	XCTAssertEqual(results.days[1].forrange,1);
	XCTAssertEqual(results.days[1].backrange,1);
	
	//tuesday
	XCTAssertEqual(results.days[2].isDayActive,true);
	XCTAssertEqual(results.days[2].forrange,1);
	XCTAssertEqual(results.days[2].backrange,1);
	
	//wednesday
	XCTAssertEqual(results.days[3].isDayActive,true);
	XCTAssertEqual(results.days[3].forrange,2);
	XCTAssertEqual(results.days[3].backrange,1);
	
	//thurday
	XCTAssertEqual(results.days[4].isDayActive,false);
	XCTAssertEqual(results.days[4].forrange,1);
	XCTAssertEqual(results.days[4].backrange,1);
	
	//friday
	XCTAssertEqual(results.days[5].isDayActive,true);
	XCTAssertEqual(results.days[5].forrange,1);
	XCTAssertEqual(results.days[5].backrange,2);
	
	//saturday
	XCTAssertEqual(results.days[6].isDayActive,true);
	XCTAssertEqual(results.days[6].forrange,15);
	XCTAssertEqual(results.days[6].backrange,1);
}

-(void)testIsTodayADueDate {
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
	
	intervalPointList.days[3].isDayActive = true; //wed
	testContext.dayStartHour = 0;
	testContext.intervalPoints = &intervalPointList;
	testContext.intervalSize = 3;
	testContext.weekStartOffset = 0;
	
	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 31, .timezoneOffset = -18000};
	
	
	bool result;
	SHErrorCode status = SH_NO_ERROR;
	
	testContext.savedPrevDate = &contextDate;
	status = SH_isDateADueDate_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertTrue(result);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = 18000};
	status = SH_isDateADueDate_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertTrue(result);
	
	testContext.dayStartHour = 21600;

	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 31, .timezoneOffset = 18000};
	status = SH_isDateADueDate_WEEKLY(&testDate, &testContext, &result);
	XCTAssertTrue(result);
	XCTAssertEqual(status, SH_NO_ERROR);
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11};
	status = SH_isDateADueDate_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_INVALID_STATE);
	XCTAssertTrue(!result);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 2, .day = 1, .timezoneOffset = 18000};
	status = SH_isDateADueDate_WEEKLY(&testDate, &testContext, &result);
	XCTAssertEqual(status, SH_INVALID_STATE);
	XCTAssertTrue(!result);
}


@end
