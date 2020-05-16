//
//  SHMissedDaysSameWeek.m
//  SHSpecial_CTests
//
//  Created by Joel Pridgen on 5/15/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <stdbool.h>
@import SHSpecial_C;

@interface SHMissedDaysSameWeek : XCTestCase

@end

@implementation SHMissedDaysSameWeek

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testSameWeek {
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

	struct SHDatetime contextDate = {.year = 2018, .month = 1, .day = 7};
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 14, .timezoneOffset = -18000};


	int64_t result = 0;
	SHErrorCode status = SH_NO_ERROR;

	testContext.savedPrevDate = &contextDate;
	
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 6);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 5);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 4);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 9, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 1);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 8, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 7, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
	
	
	contextDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13};
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13, .timezoneOffset = -18000};
	status = SH_missedDays(&testDate, &testContext, &result);
	XCTAssertEqual(result, 0);
}

@end
