//
//  SHDatetimeTests.m
//  SHDatetimeTests
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHDatetime;

@interface SHDatetimeTests : XCTestCase

@end

@implementation SHDatetimeTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testCreateDate{
	struct SHDatetime testDate;
	SHErrorCode status = SH_NO_ERROR;
	double ans = 0;

	
	int32_t testOffset = -18000;
	testDate = (struct SHDatetime){.year = 1970, .month = 1, .day = 1, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans,18000);
	
	testDate = (struct SHDatetime){.year = 1970, .month = 1, .day = 27, .hour = 13,
		.minute = 35, .second = 12, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans,2313312);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 1, .day = 13, .hour = 14,
		.minute = 27, .second = 15, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans,569100435);

	testDate = (struct SHDatetime){.year = 1997, .month = 1, .day = 1, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 852094800);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 2, .day = 28, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 573022800);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 2, .day = 29, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 573109200);
	
	testOffset = -14400;
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 27, .hour = 13,
		.minute = 35, .second = 12, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 578165712);
	
	testDate = (struct SHDatetime){.year = 1997, .month = 4, .day = 27, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 862113600);
	
	testOffset = 0;
	
	testDate = (struct SHDatetime){.year = 1972, .month = 2, .day = 29, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 68169600);
	
	testDate = (struct SHDatetime){.year = 1972, .month = 3, .day = 1, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 68256000);
	
	testDate = (struct SHDatetime){.year = 2038, .month = 1, .day = 19, .hour = 3,
		.minute = 14, .second = 07, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 2147483647);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 31, .hour = 23,
		.minute = 59, .second = 59, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -1);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 31, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -86400);
	
	testDate = (struct SHDatetime){.year = 1901, .month = 12, .day = 13, .hour = 20,
		.minute = 45, .second = 52, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -2147483648);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 3, .day = 1, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -26438400);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 2, .day = 28, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -26524800);
	
	testDate = (struct SHDatetime){.year = 1968, .month = 3, .day = 1, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -57974400);
	
	testDate = (struct SHDatetime){.year = 1968, .month = 2, .day = 28, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -58147200);
	
	testDate = (struct SHDatetime){.year = 1968, .month = 2, .day = 29, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -58060800);
	
	testDate = (struct SHDatetime){.year = 1967, .month = 4, .day = 27, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, -84672000);
	
	testDate = (struct SHDatetime){.year = 2104, .month = 12, .day = 31, .hour = 0,
		.minute = 0, .second = 0, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 4260124800);
	
	testDate = (struct SHDatetime){.year = 2104, .month = 12, .day = 31, .hour = 23,
		.minute = 59, .second = 59, .timezoneOffset = testOffset};
	status = SH_dtToTimestamp(&testDate, &ans);
	XCTAssertEqual(ans, 4260211199);
	
}


-(void)testDecimalTime{
	struct SHDatetime dt = {.year = 2018,.month = 3, .day = 9, .timezoneOffset = 0,
		.hour = 2, .minute = 13, .second = 0, .milisecond = 96
	};
	double precision = .0001;
	double timestamp = 0;
	SHErrorCode status = SH_dtToTimestamp(&dt,&timestamp);
	
	SH_dtSetYear(&dt, 9999);
	SH_dtSetMonth(&dt, 12);
	SH_dtSetDay(&dt, 31);
	SH_dtSetHour(&dt, 23);
	SH_dtSetMinute(&dt, 59);
	SH_dtSetSecond(&dt, 59);
	status = SH_dtToTimestamp(&dt, &timestamp);
	XCTAssertEqualWithAccuracy(253402300799.096,timestamp,precision);
	
	SH_timestampToDt(253402300799.096025,0,&dt);
	XCTAssertEqual(dt.year,9999);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	XCTAssertEqual(dt.milisecond,96);
	
	SH_dtSetYear(&dt, 1969);
	SH_dtSetMonth(&dt, 1);
	SH_dtSetDay(&dt, 1);
	SH_dtSetHour(&dt, 0);
	SH_dtSetMinute(&dt, 0);
	SH_dtSetSecond(&dt, 0);
	status = SH_dtToTimestamp(&dt, &timestamp);
	XCTAssertEqualWithAccuracy(timestamp,-31536000.096,precision);
	
	SH_dtSetYear(&dt, 1);
	SH_dtSetMonth(&dt, 1);
	SH_dtSetDay(&dt, 1);
	SH_dtSetHour(&dt, 0);
	SH_dtSetMinute(&dt, 0);
	SH_dtSetSecond(&dt, 0);
	status = SH_dtToTimestamp(&dt, &timestamp);
	XCTAssertEqualWithAccuracy(timestamp,-62135596800.096,precision);
	
}


-(void)testDayOfYear{
	struct SHDatetime dt;
	double timestamp = 10022400;
	SH_timestampToDt(timestamp, 0, &dt);
	int32_t result = SH_calcDayOfYear(&dt);
	XCTAssertEqual(result,117);
	
	timestamp = 73180800;
	SH_timestampToDt(timestamp, 0, &dt);
	result = SH_calcDayOfYear(&dt);
	XCTAssertEqual(result,118);
	
	timestamp = 5097600;
	SH_timestampToDt(timestamp, 0, &dt);
	result = SH_calcDayOfYear(&dt);
	
	XCTAssertEqual(result,60);
	timestamp = 68256000;
	SH_timestampToDt(timestamp, 0, &dt);
	result = SH_calcDayOfYear(&dt);
	
	XCTAssertEqual(result,61);
	timestamp = 68169600;
	SH_timestampToDt(timestamp, 0, &dt);
	result = SH_calcDayOfYear(&dt);
	XCTAssertEqual(result,60);
	
	timestamp = 5011200;
	SH_timestampToDt(timestamp, 0, &dt);
	result = SH_calcDayOfYear(&dt);
	XCTAssertEqual(result,59);
}


-(void)testIsLeapYear {
	bool result = SH_isLeapYear(1968);
	XCTAssertTrue(result);
	
	result = SH_isLeapYear(1969);
	XCTAssertTrue(!result);
	
	result = SH_isLeapYear(1967);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1966);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1965);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1964);
	XCTAssertTrue(result);
	result = SH_isLeapYear(1970);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(2000);
	XCTAssertTrue(result);
	result = SH_isLeapYear(1971);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1972);
	XCTAssertTrue(result);
	result = SH_isLeapYear(1900);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1888);
	XCTAssertTrue(result);
	result = SH_isLeapYear(1988);
	XCTAssertTrue(result);
	result = SH_isLeapYear(1989);
	XCTAssertTrue(!result);
	result = SH_isLeapYear(1990);
	XCTAssertTrue(!result);
}


-(void)testAddDays{
	struct SHTimeshift dst[2] = {
			{3,11,2,0,SH_HOUR_IN_SECONDS,{0}},
			{11,4,2,0,0,{0}}
		};
	struct SHDatetime dt = {.year = 2018,.month = 3, .day = 9, .timezoneOffset = -5*SH_HOUR_IN_SECONDS,
			.hour = 2, .minute = 13, .second = 0
		};
	

	dt.shifts = dst;
	dt.shiftLen = sizeof(dst)/sizeof(struct SHTimeshift);
	dt.currentShiftIdx = SH_selectTimeShiftIdxForDt(&dt, dst, dt.shiftLen);
	struct SHDatetime copy = dt;
	SH_addDaysToDt(&copy, 2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -4);
	dt.hour = 1;
	copy = dt;
	
	SH_addDaysToDt(&copy,2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -5);
	dt.hour = 1;
	dt.minute = 59;
	copy = dt;
	
	SH_addDaysToDt(&copy,2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,59);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -5);
	dt.hour = 2;
	dt.minute = 0;
	copy = dt;
	
	SH_addDaysToDt(&copy,2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,0);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -4);
	
	dt.hour = 3;
	dt.minute = 1;
	copy = dt;
	
	SH_addDaysToDt(&copy,2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -4);
	
	copy = dt;
	
	dt.hour = 6;
	SH_addDaysToDt(&copy,3, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,12);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -4);
	
	dt.timezoneOffset = -4 * SH_HOUR_IN_SECONDS;
	dt.month = 11;
	dt.day = 3;
	dt.hour = 0;
	dt.minute = 1;
	dt.currentShiftIdx = SH_selectTimeShiftIdxForDt(&dt,dst,dt.shiftLen);
	copy = dt;
	
	SH_addDaysToDt(&copy,1, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,0);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -4);
	
	dt.hour = 2;
	copy = dt;
	
	SH_addDaysToDt(&copy,1, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -5);
	
	dt.hour = 3;
	copy = dt;
	
	SH_addDaysToDt(&copy,1, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -5);
	
	dt.hour = 2;
	copy = dt;
	
	SH_addDaysToDt(&copy,2, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(copy.day,5);
	XCTAssertEqual(copy.hour,2);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset, SH_HOUR_IN_SECONDS * -5);
	
	
	struct SHDatetime testDate = {.year = 1988, .month = 4, .day = 27,
		.hour = 13, .minute = 35, .second = 12, .timezoneOffset = -18000};
	copy = testDate;
	
	double timestamp = 0;
	SH_addDaysToDt(&copy, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 578342112);
	
//test rollover to next month
	copy = testDate;
	SH_addDaysToDt(&copy, 4, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 578514912);
	
//test rollover to next year during a leap year
	copy = testDate;
	SH_addDaysToDt(&copy, 249, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 599682912);
//test rollover from febuary during leap year
	testDate = (struct SHDatetime){ .year = 1988, .month = 2, .day = 28,
		.hour = 13, .minute = 35, .second = 12, .timezoneOffset = -18000};
	copy = testDate;
	SH_addDaysToDt(&copy, 1, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 573158112);
	
	copy = testDate;
	SH_addDaysToDt(&copy, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 573244512);
	copy = testDate;
//test rollover from febuary during non leap year
	testDate = (struct SHDatetime){ .year = 1989, .month = 2, .day = 28,
		.hour = 13, .minute = 35, .second = 12, .timezoneOffset = -18000};
	copy = testDate;
	SH_addDaysToDt(&copy, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 604866912);
}


-(void)testAdjustDateYear{
	int32_t testOffset = -14400;
	struct SHDatetime testDate = {.year = 1988, .month = 4, .day = 27, .hour = 13,
		.minute = 35, .second = 12, .timezoneOffset = testOffset};
	struct SHDatetime copy;
	copy = testDate;
	SHErrorCode status = SH_addYearsToDt(&copy, 9, SH_TIME_ADJUST_NO_OPTION);
	XCTAssertEqual(status, SH_NO_ERROR);
	double resultTimestamp = 0;

	status = SH_dtToTimestamp(&copy, &resultTimestamp);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(resultTimestamp, 862162512);
	
	copy = testDate;
	status = SH_addYearsToDt(&copy, -8, SH_TIME_ADJUST_NO_OPTION);
	status = SH_dtToTimestamp(&copy, &resultTimestamp);
	XCTAssertEqual(resultTimestamp, 325704912);
}

-(void)testAdjustDateMonth{
	struct SHDatetime testDate = {.year = 1988, .month = 4, .day = 16,
		.hour = 13, .minute = 35, .second = 12, .timezoneOffset = -18000 };
	struct SHDatetime copy = testDate;
	double timestamp = 0;
	SH_addMonthsToDt(&copy, 2, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 582489312);
	
	copy = testDate;
	SH_addMonthsToDt(&copy, 9, SH_TIME_ADJUST_NO_OPTION);
	SH_dtToTimestamp(&copy, &timestamp);
	XCTAssertEqual(timestamp, 600978912);
}


-(void)testGetDaysLeft{

	struct SHDatetime fromTime = { .year = 1988, .month = 4, .day = 27,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = -18000};
	struct SHDatetime toTime = { .year = 1988, .month = 4, .day = 28,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = -18000};
	int64_t dayDiff = 0;
	SH_dateDiffDays(&fromTime, &toTime, &dayDiff);
	XCTAssertEqual(dayDiff,1);
}


-(void)testGetDayOfWeek{
	int32_t testOffset = -18000;
	//time zone is GMT
	struct SHDatetime testDate = {.year = 2018, .month = 1, .day = 7,
		.timezoneOffset = testOffset};
	int32_t result = -1;
	
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,0);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 8,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,1);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 9,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,2);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 10,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,3);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 11,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,4);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 12,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,5);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 13,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,6);
	
	testDate = (struct SHDatetime){.year = 2018, .month = 1, .day = 14,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,0);
	
	testDate = (struct SHDatetime){.year = 1970, .month = 1, .day = 1,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,4);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 31,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,3);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 30,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,2);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 29,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,1);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 28,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,0);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 27,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,6);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 26,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,5);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 25,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,4);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 12, .day = 24,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,3);
	
	testDate = (struct SHDatetime){.year = 1969, .month = 4, .day = 27,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,0);
	
	testDate = (struct SHDatetime){.year = 1776, .month = 7, .day = 4,
		.timezoneOffset = testOffset};
	result = SH_weekdayIdx(&testDate, 0);
	XCTAssertEqual(result,4);
	
}


-(void)testCalcWeekStart {
	int32_t testOffset = 0;
	
	struct SHDatetime testDate = {.year = 1988, .month = 4, .day = 27,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	struct SHDatetime expectedDate = {.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	struct SHDatetime resultDate;
	
	
	double timestamp = 0;
	double expectedTimestamp = -1;
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	resultDate = testDate;
	SHErrorCode status = SH_weekStart(&resultDate, 0);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 24,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 25,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 26,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 28,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
		
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 29,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 29,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);

	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 30,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	expectedDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_weekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
}


-(void)testCalcNextWeekStart {
	int32_t testOffset = 0;
	
	struct SHDatetime testDate = {.year = 1988, .month = 4, .day = 27,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	struct SHDatetime expectedDate =
		{.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	struct SHDatetime resultDate;
	double timestamp = 0;
	double expectedTimestamp = -1;
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
	
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 24,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 25,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 26,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 28,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 29,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 29,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 4, .day = 30,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	expectedDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 8,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dtToTimestamp(&expectedDate, &expectedTimestamp);
		
	testDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 15, .minute = 32, .second = 17, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
	
	testDate = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	resultDate = testDate;
	SH_nextWeekStart(&resultDate, 0);
	SH_dtToTimestamp(&resultDate, &timestamp);
	XCTAssertEqual(timestamp, expectedTimestamp);
	
}


-(void)testSameWeekAs {
	int32_t testOffset = 0;
	struct SHDatetime testDate1 = {.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	struct SHDatetime testDate2 = {.year = 1988, .month = 4, .day = 30,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	bool result;
	SH_areSameWeek(&testDate1, &testDate2, 0, &result);
	XCTAssertTrue(result);
	SH_areSameWeek(&testDate2, &testDate1, 0, &result);
	XCTAssertTrue(result);
	
	struct SHDatetime testDateAfterWeek = {.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_areSameWeek(&testDate2, &testDateAfterWeek, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDateAfterWeek, &testDate2, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDate1, &testDateAfterWeek, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDateAfterWeek, &testDate1, 0, &result);
	XCTAssertTrue(!result);
	
	struct SHDatetime testDateBeforeWeek = {.year = 1988, .month = 4, .day = 23,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDateBeforeWeek, &testDate2, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDate1, &testDateBeforeWeek, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDateBeforeWeek, &testDate1, 0, &result);
	XCTAssertTrue(!result);
	
	SH_areSameWeek(&testDateBeforeWeek, &testDateAfterWeek, 0, &result);
	XCTAssertTrue(!result);
	SH_areSameWeek(&testDateAfterWeek, &testDateBeforeWeek, 0, &result);
	XCTAssertTrue(!result);
}


-(void)testWeeksBetween {
	int32_t testOffset = 0;
	/*
			SU	MO	TU	WE	TH	FR	SA
			17	18	19	20	21	22	23
			24	25	26	27	28	29	30
	May
			01	02	03	04	05	06	07
			08	09	10	11	12	13	14
			15	16	17	18	19	20	21
			22	23	24	25	26	27	28
			29	30	31
	June
									01	02	03	04
			05	06	07	08	09	10	11
			12	13	14	15	16	17	18
			19	20	21	22	23	24	25
			26	27	28	29	30
	*/
	struct SHDatetime testDate1 = {.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	struct SHDatetime testDate2 = {.year = 1988, .month = 4, .day = 30,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	int64_t result = -1;
	
	SHErrorCode status = SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(result, 0);

	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 23,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 0);
	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 23,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 0);

	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 19,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 0);

	
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 1, &result);
	XCTAssertEqual(result, 0);
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 2, &result);
	XCTAssertEqual(result, 0);
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 3, &result);
	XCTAssertEqual(result, 1);
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 4, &result);
	XCTAssertEqual(result, 1);
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 5, &result);
	XCTAssertEqual(result, 1);
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 6, &result);
	XCTAssertEqual(result, 1);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 4, .day = 29,
		.hour = 23, .minute = 59, .second = 58, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 6, &result);
	XCTAssertEqual(result, 0);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 4, .day = 30,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 6, &result);
	XCTAssertEqual(result, 1);
	
	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 24,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	testDate2 = (struct SHDatetime){.year = 1988, .month = 5, .day = 1,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 0);
	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 23,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 1);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 5, .day = 7,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 1);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 5, .day = 8,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 2);
	
	testDate1 = (struct SHDatetime){.year = 1988, .month = 4, .day = 19,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 2);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 6, .day = 5,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 6);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 6, .day = 8,
		.hour = 0, .minute = 0, .second = 0, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 6);
	
	testDate2 = (struct SHDatetime){.year = 1988, .month = 6, .day = 4,
		.hour = 23, .minute = 59, .second = 59, .timezoneOffset = testOffset};
	SH_dateDiffFullWeeks(&testDate1, &testDate2, 0, &result);
	XCTAssertEqual(result, 5);
}


-(void)testGetDayOfWeekOffsetted {
	struct SHDatetime sun = {.year = 2018, .month = 1, .day = 7};
	struct SHDatetime mon = {.year = 2018, .month = 1, .day = 8};
	struct SHDatetime tue = {.year = 2018, .month = 1, .day = 9};
	struct SHDatetime wed = {.year = 2018, .month = 1, .day = 10};
	struct SHDatetime thurs = {.year = 2018, .month = 1, .day = 11};
	struct SHDatetime fri = {.year = 2018, .month = 1, .day = 12};
	struct SHDatetime sat = {.year = 2018, .month = 1, .day = 13};
	int32_t offset = 0;
	int32_t result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 6);

	offset = 1;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 5);
	
	offset = 2;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 4);
	
	offset = 3;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 3);
	
	offset = 4;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 2);
	
	offset = 5;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 1);
	
	offset = 6;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 6);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 0);
	
	offset = 7;
	result = SH_weekdayIdx(&sun, offset);
	XCTAssertEqual(result, 0);
	result = SH_weekdayIdx(&mon, offset);
	XCTAssertEqual(result, 1);
	result = SH_weekdayIdx(&tue, offset);
	XCTAssertEqual(result, 2);
	result = SH_weekdayIdx(&wed, offset);
	XCTAssertEqual(result, 3);
	result = SH_weekdayIdx(&thurs, offset);
	XCTAssertEqual(result, 4);
	result = SH_weekdayIdx(&fri, offset);
	XCTAssertEqual(result, 5);
	result = SH_weekdayIdx(&sat, offset);
	XCTAssertEqual(result, 6);
}

@end
