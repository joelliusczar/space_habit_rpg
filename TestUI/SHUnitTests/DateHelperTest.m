//
//	DateHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/NSDate+DateHelper.h>
#import "NSDate+testReplace.h"
#import <SHCommon/NSLocale+Helper.h>
#import "SHDatetime.h"




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


-(void)testCreateDate{
	NSDate *testDate;
	
	double ans = 0;
	SHErrorCode error;
	shTryCreateDate(0,1,1,0,&ans,&error);
	
	
	testDate = [NSDate createDateTimeWithYear:1970 month:1 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970,18000);
	testDate = [NSDate createDateTimeWithYear:1970 month:1 day:27 hour:13 minute:35 second:12];
	XCTAssertEqual(testDate.timeIntervalSince1970,2313312);
	testDate = [NSDate createDateTimeWithYear:1988 month:1 day:13 hour:14 minute:27 second:15];
	XCTAssertEqual(testDate.timeIntervalSince1970,569100435);
	testDate = [NSDate createDateTimeWithYear:1997 month:1 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 852094800);
	testDate = [NSDate createDateTimeWithYear:1988 month:2 day:28 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 573022800);
	testDate = [NSDate createDateTimeWithYear:1988 month:2 day:29 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 573109200);
	
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:-14400];
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
	XCTAssertEqual(testDate.timeIntervalSince1970, 578165712);
	testDate = [NSDate createDateTimeWithYear:1997 month:4 day:27 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 862113600);
	
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	testDate = [NSDate createDateTimeWithYear:1972 month:2 day:29 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 68169600);
	testDate = [NSDate createDateTimeWithYear:1972 month:3 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 68256000);
	testDate = [NSDate createDateTimeWithYear:2038 month:1 day:19 hour:3 minute:14 second:07];
	XCTAssertEqual(testDate.timeIntervalSince1970, 2147483647);
	testDate = [NSDate createDateTimeWithYear:1969 month:12 day:31 hour:23 minute:59 second:59];
	XCTAssertEqual(testDate.timeIntervalSince1970, -1);
	testDate = [NSDate createDateTimeWithYear:1969 month:12 day:31 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -86400);
	testDate = [NSDate createDateTimeWithYear:1901 month:12 day:13 hour:20 minute:45 second:52];
	XCTAssertEqual(testDate.timeIntervalSince1970, -2147483648);
	testDate = [NSDate createDateTimeWithYear:1969 month:3 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -26438400);
	testDate = [NSDate createDateTimeWithYear:1969 month:2 day:28 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -26524800);
	testDate = [NSDate createDateTimeWithYear:1968 month:3 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -57974400);
	testDate = [NSDate createDateTimeWithYear:1968 month:2 day:28 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -58147200);
	testDate = [NSDate createDateTimeWithYear:1968 month:2 day:29 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -58060800);
	testDate = [NSDate createDateTimeWithYear:1967 month:4 day:27 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, -84672000);
	testDate = [NSDate createDateTimeWithYear:2104 month:12 day:31 hour:0 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970, 4260124800);
	testDate = [NSDate createDateTimeWithYear:2104 month:12 day:31 hour:23 minute:59 second:59];
	XCTAssertEqual(testDate.timeIntervalSince1970, 4260211199);
	
	
}


-(void)testTimestampToDateObj{
	SHDatetime dt;
	SHErrorCode error;
	
	shTryTimestampToDt(-2051222400,0,&dt,&error);
	XCTAssertEqual(dt.year,1905);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-2082844800,0,&dt,&error);
	XCTAssertEqual(dt.year,1904);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-126230399,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	shTryTimestampToDt(-2145916799,0,&dt,&error);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	shTryTimestampToDt(157766399,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-126230400,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-2145916800,0,&dt,&error);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(68256000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(94694400,0,&dt,&error);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-63158401,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(126230399,0,&dt,&error);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(126230400,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(136252800,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(252460800,0,&dt,&error);
	XCTAssertEqual(dt.year,1978);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(94694399,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-63158400,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(63158400,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(0,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(1,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	shTryTimestampToDt(2851200,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,3);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(31449600,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-31536000,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(63071999,0,&dt,&error);
	XCTAssertEqual(dt.year,1971);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(230947200,0,&dt,&error);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(65318400,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(68083200,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(68169600,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,29);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(68256000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(73180800,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(220924800,0,&dt,&error);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(956793600,0,&dt,&error);
	XCTAssertEqual(dt.year,2000);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(1009756799,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(1009670400,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(1009843199,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(199411200,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(191548800,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(220838400,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(2147483647,0,&dt,&error);
	XCTAssertEqual(dt.year,2038);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,19);
	XCTAssertEqual(dt.hour,3);
	XCTAssertEqual(dt.minute,14);
	XCTAssertEqual(dt.second,7);
	
	shTryTimestampToDt(63072000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-31536000,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-384780,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-31536001,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-31920780,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-63543180,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-91191180,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,10);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-95079180,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-126615180,0,&dt,&error);
	XCTAssertEqual(dt.year,1965);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-189773580,0,&dt,&error);
	XCTAssertEqual(dt.year,1963);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-86400,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-86401,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-1,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-53049600,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-2208988800,0,&dt,&error);
	XCTAssertEqual(dt.year,1900);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4107542400,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4102444800,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4133980799,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4165430399,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4165344000,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4165430400,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4165516799,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4165516800,0,&dt,&error);
	XCTAssertEqual(dt.year,2102);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4260124800,0,&dt,&error);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4260211199,0,&dt,&error);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4260211200,0,&dt,&error);
	XCTAssertEqual(dt.year,2105);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4102358399,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4102358400,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4102444799,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(4133980800,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4139078400,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4138992000,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(4134067200,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(7289654400,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(7289740800,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(7294752000,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(10445328000,0,&dt,&error);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(10445414400,0,&dt,&error);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(13569465600,0,&dt,&error);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(13601087999,0,&dt,&error);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(13601088000,0,&dt,&error);
	XCTAssertEqual(dt.year,2401);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-2208988801,0,&dt,&error);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-2240524800,0,&dt,&error);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-8520336001,0,&dt,&error);
	XCTAssertEqual(dt.year,1699);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-11644473601,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-11673417601,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-11676009602,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,58);
	
	shTryTimestampToDt(-11676096001,0,&dt,&error);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-11707632000,0,&dt,&error);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	shTryTimestampToDt(-11802240001,0,&dt,&error);
	XCTAssertEqual(dt.year,1596);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(-14831769601,0,&dt,&error);
	XCTAssertEqual(dt.year,1499);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	shTryTimestampToDt(253402300799,0,&dt,&error);
	XCTAssertEqual(dt.year,9999);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
}

-(void)testDecimalTime{
	SHDatetime dt = {.year = 2018,.month = 3, .day = 9, .timezoneOffset = 0,
		.hour = 2, .minute = 13, .second = 0, .milisecond = 96
	};
	double precision = .0001;
	SHErrorCode error;
	double timestamp = shDtToTimestamp(&dt,&error);
	
	dt.year = 9999;
	dt.month = 12;
	dt.day = 31;
	dt.hour = 23;
	dt.minute = 59;
	dt.second = 59;
	timestamp = shDtToTimestamp(&dt,&error);
	XCTAssertEqualWithAccuracy(253402300799.096,timestamp,precision);
	
	shTryTimestampToDt(253402300799.096025,0,&dt,&error);
	XCTAssertEqual(dt.year,9999);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	XCTAssertEqual(dt.milisecond,96);
	
	dt.year = 1969;
	dt.month = 1;
	dt.day = 1;
	dt.hour = 0;
	dt.minute = 0;
	dt.second = 0;
	timestamp = shDtToTimestamp(&dt,&error);
	XCTAssertEqualWithAccuracy(timestamp,-31536000.096,precision);
	
	dt.year = 1;
	dt.month = 1;
	dt.day = 1;
	dt.hour = 0;
	dt.minute = 0;
	dt.second = 0;
	timestamp = shDtToTimestamp(&dt,&error);
	XCTAssertEqualWithAccuracy(timestamp,-62135596800.096,precision);
	
}

-(void)testDayOfYear{
	SHErrorCode error = 0;
	int result = shCalcDayOfYearFromTimestamp(10022400,0,&error);
	XCTAssertEqual(result,117);
	result = shCalcDayOfYearFromTimestamp(73180800,0,&error);
	XCTAssertEqual(result,118);
	result = shCalcDayOfYearFromTimestamp(5097600,0,&error);
	XCTAssertEqual(result,60);
	result = shCalcDayOfYearFromTimestamp(68256000,0,&error);
	XCTAssertEqual(result,61);
	result = shCalcDayOfYearFromTimestamp(68169600,0,&error);
	XCTAssertEqual(result,60);
	result = shCalcDayOfYearFromTimestamp(5011200,0,&error);
	XCTAssertEqual(result,59);
}

-(void)testAddDayToTs{
	double ts = 578102400;
	double ans = 0;
	SHErrorCode error;
	shTryAddDaysToTimestamp(ts,0,0,&ans,&error);
	XCTAssertEqual(ts,ans);
	shTryAddDaysToTimestamp(ts,1,0,&ans,&error);
	XCTAssertEqual(578188800,ans);
	shTryAddDaysToTimestamp(ts,-1,0,&ans,&error);
	XCTAssertEqual(578016000,ans);
	shTryAddDaysToTimestamp(ts,4,0,&ans,&error);
	XCTAssertEqual(578448000,ans);
}

-(void)testAddDays{
	SHTimeshift dst[2] = {
		{3,11,2,0,HOUR_IN_SECONDS,{0}},
		{11,4,2,0,0,{0}}
	};
	SHErrorCode error;
	SHDatetime dt = {.year = 2018,.month = 3, .day = 9, .timezoneOffset = -5*HOUR_IN_SECONDS,
		.hour = 2, .minute = 13, .second = 0
	};
	

	dt.shifts = dst;
	dt.shiftLen = sizeof(dst)/sizeof(SHTimeshift);
	dt.currentShiftIdx = shSelectTimeShiftForDt(&dt,dst,dt.shiftLen);
	SHDatetime copy = dt;
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-4);
	dt.hour = 1;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-5);
	dt.hour = 1;
	dt.minute = 59;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,59);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-5);
	dt.hour = 2;
	dt.minute = 0;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,0);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-4);
	
	dt.hour = 3;
	dt.minute = 1;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-4);
	
	copy = dt;
	
	dt.hour = 6;
	shTryAddDaysToDtInPlace(&copy,3,0,&error);
	XCTAssertEqual(copy.day,12);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-4);
	
	dt.timezoneOffset = -4*HOUR_IN_SECONDS;
	dt.month = 11;
	dt.day = 3;
	dt.hour = 0;
	dt.minute = 1;
	dt.currentShiftIdx = shSelectTimeShiftForDt(&dt,dst,dt.shiftLen);
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,0);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-4);
	
	dt.hour = 2;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-5);
	
	dt.hour = 3;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-5);
	
	dt.hour = 2;
	copy = dt;
	
	shTryAddDaysToDtInPlace(&copy,2,0,&error);
	XCTAssertEqual(copy.day,5);
	XCTAssertEqual(copy.hour,2);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,HOUR_IN_SECONDS*-5);
}


-(void)testAdjustDateYear{
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:-14400];
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
	NSDate *result = [testDate dateAfterYears:9 months:0 days:0];
	XCTAssertEqual(result.timeIntervalSince1970, 862162512);
	result = [testDate dateAfterYears:-8 months:0 days:0];
	XCTAssertEqual(result.timeIntervalSince1970, 325704912);
}


-(void)testAdjustDateMonth{
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:16 hour:13 minute:35 second:12];
	NSDate *result = [testDate dateAfterYears:0 months:2 days:0];
	XCTAssertEqual(result.timeIntervalSince1970, 582489312);
	result = [testDate dateAfterYears:0 months:9 days:0];
	XCTAssertEqual(result.timeIntervalSince1970, 600978912);
	
}


-(void)testAdjustDateDay{
//test simple adding
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:35 second:12];
	NSDate *result = [testDate dateAfterYears:0 months:0 days:2];
	XCTAssertEqual(result.timeIntervalSince1970, 578342112);
//test rollover to next month
	result = [testDate dateAfterYears:0 months:0 days:4];
	XCTAssertEqual(result.timeIntervalSince1970, 578514912);
//test rollover to next year during a leap year
	result = [testDate dateAfterYears:0 months:0 days:249];
	XCTAssertEqual(result.timeIntervalSince1970, 599682912);
//test rollover from febuary during leap year
	testDate = [NSDate createDateTimeWithYear:1988 month:2 day:28 hour:13 minute:35 second:12];
	result = [testDate dateAfterYears:0 months:0 days:1];
	XCTAssertEqual(result.timeIntervalSince1970, 573158112);
	result = [testDate dateAfterYears:0 months:0 days:2];
	XCTAssertEqual(result.timeIntervalSince1970, 573244512);
//test rollover from febuary during non leap year
	testDate = [NSDate createDateTimeWithYear:1989 month:2 day:28 hour:13 minute:35 second:12];
	result = [testDate dateAfterYears:0 months:0 days:2];
	XCTAssertEqual(result.timeIntervalSince1970, 604866912);
}


-(void)testGetDaysLeft{
	NSDate *fromTime = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:0 minute:0 second:0];
	NSDate *toTime = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:0 minute:0 second:0];
	int daysLeft = (int)[NSDate daysBetween:fromTime to:toTime];
	XCTAssertEqual(daysLeft,1);
}


-(void)testSwizzleDate{
	testTodayReplacement = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:13 minute:45 second:40 timeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
	[NSDate swizzleThatShit];
	NSDate *testDate = [NSDate date];
	XCTAssertEqual(testDate.timeIntervalSince1970,testTodayReplacement.timeIntervalSince1970);
	
}


-(void)testCreateSimpleTime{
	NSDate *testDate = [NSDate createSimpleTimeWithHour:2 minute:0 second:0];
	XCTAssertEqual(testDate.timeIntervalSince1970,25200);
}


-(void)testTimeOfDayInPreferredFormat{
	NSString *result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
	XCTAssertTrue([result isEqualToString:@"1:15 PM"]);
	SharedGlobal.inUseLocale = [NSLocale localeWithLocaleIdentifier:@"en_GB"];
	result = [NSDate timeOfDayInSystemPreferredFormat:13 andMinute:15];
	XCTAssertTrue([result isEqualToString:@"13:15"]);
}


-(void)testHourInFormat{
	//0-23
	NSLocale *testLocale =
	[NSLocale localeWithLocaleIdentifier:@"de_DE"];//HH 'Uhr'
	NSInteger result = [testLocale hourInLocaleFormat:0];
	XCTAssertEqual(result,0);
	result = [testLocale hourInLocaleFormat:1];
	XCTAssertEqual(result,1);
	result = [testLocale hourInLocaleFormat:11];
	XCTAssertEqual(result,11);
	result = [testLocale hourInLocaleFormat:12];
	XCTAssertEqual(result,12);
	result = [testLocale hourInLocaleFormat:22];
	XCTAssertEqual(result,22);
	result = [testLocale hourInLocaleFormat:23];
	XCTAssertEqual(result,23);
	XCTAssertThrows([testLocale hourInLocaleFormat:24]);
	
	//1-24
	NSInteger formatMask = [NSLocale hourMaskForGivenFormat:@"k"];
	result = [NSLocale hour:0 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,1);
	result = [NSLocale hour:1 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,2);
	result = [NSLocale hour:11 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,12);
	result = [NSLocale hour:12 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,13);
	result = [NSLocale hour:22 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,23);
	result = [NSLocale hour:23 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,24);
	XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
	
	//0-11
	formatMask = [NSLocale hourMaskForGivenFormat:@"K"];
	result = [NSLocale hour:0 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,0);
	result = [NSLocale hour:1 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,1);
	result = [NSLocale hour:11 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,11);
	result = [NSLocale hour:12 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,0);
	result = [NSLocale hour:13 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,1);
	result = [NSLocale hour:14 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,2);
	result = [NSLocale hour:22 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,10);
	result = [NSLocale hour:23 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,11);
	XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
	
	//1-12
	formatMask = [NSLocale hourMaskForGivenFormat:@"h"];
	result = [NSLocale hour:0 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,12);
	result = [NSLocale hour:1 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,1);
	result = [NSLocale hour:11 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,11);
	result = [NSLocale hour:12 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,12);
	result = [NSLocale hour:13 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,1);
	result = [NSLocale hour:14 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,2);
	result = [NSLocale hour:22 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,10);
	result = [NSLocale hour:23 inGivenFormatMask:formatMask];
	XCTAssertEqual(result,11);
	XCTAssertThrows([NSLocale hour:24 inGivenFormatMask:formatMask]);
}


NSInteger calcDaysFromBase(NSInteger span){
	NSDate *base = [NSDate createSimpleDateWithYear:2017 month:1 day:7];
	NSDate *adjusted = [base dateAfterYears:0 months:0 days:span];
	NSInteger result = [NSDate daysBetween:base to:adjusted];
	return result;
}

-(void)testDaysBetween{
	XCTAssertEqual(calcDaysFromBase(1),1);
	XCTAssertEqual(calcDaysFromBase(2),2);
	XCTAssertEqual(calcDaysFromBase(3),3);
	XCTAssertEqual(calcDaysFromBase(4),4);
	XCTAssertEqual(calcDaysFromBase(10),10);
	XCTAssertEqual(calcDaysFromBase(11),11);
	XCTAssertEqual(calcDaysFromBase(20),20);
	XCTAssertEqual(calcDaysFromBase(30),30);
	XCTAssertEqual(calcDaysFromBase(60),60);
	XCTAssertEqual(calcDaysFromBase(61),61);
	XCTAssertEqual(calcDaysFromBase(63),63);
	XCTAssertEqual(calcDaysFromBase(64),64);
	XCTAssertEqual(calcDaysFromBase(65),65);
	XCTAssertEqual(calcDaysFromBase(66),66);
	XCTAssertEqual(calcDaysFromBase(80),80);
	XCTAssertEqual(calcDaysFromBase(81),81);
	XCTAssertEqual(calcDaysFromBase(100),100);
	XCTAssertEqual(calcDaysFromBase(1000),1000);
	XCTAssertEqual(calcDaysFromBase(10000),10000);
}

-(void)testGetDayOfWeek{
	//time zone is GMT
	NSDate *testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:7];
	NSInteger result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,0);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:8];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,1);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:9];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,2);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:10];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,3);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:11];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,4);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,5);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:13];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,6);
	
	testDate = [NSDate createSimpleDateWithYear:2018 month:1 day:14];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,0);
	
	testDate = [NSDate createSimpleDateWithYear:1970 month:1 day:1];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,4);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:31];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,3);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:30];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,2);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:29];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,1);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:28];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,0);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:27];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,6);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:26];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,5);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:25];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,4);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:12 day:24];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,3);
	
	testDate = [NSDate createSimpleDateWithYear:1969 month:4 day:27];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,0);
	
	testDate = [NSDate createSimpleDateWithYear:1776 month:7 day:4];
	result = [testDate getWeekdayIndex];
	XCTAssertEqual(result,4);
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


-(void)testAMPMSymbol{
	NSLocale *loc = SharedGlobal.inUseLocale;
	NSString *pm = loc.PMSymbol;
	NSString *am = loc.AMSymbol;
	XCTAssertTrue([pm isEqualToString:@"PM"]);
	XCTAssertTrue([am isEqualToString:@"AM"]);
}

@end
