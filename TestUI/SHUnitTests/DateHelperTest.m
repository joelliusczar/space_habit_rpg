//
//	DateHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+testReplace.h"
#import <XCTest/XCTest.h>
@import SHCommon;
#import <SHDatetime/SHDatetime.h>




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
	SHError error;
	memset(&error, 0, sizeof(SHError));
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
	SHError error;
	
	memset(&error,0,sizeof(SHError));
	
	SH_timestampToDt(-2051222400,0,&dt,&error);
	XCTAssertEqual(dt.year,1905);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2082844800,0,&dt,&error);
	XCTAssertEqual(dt.year,1904);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-126230399,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(-2145916799,0,&dt,&error);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(157766399,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-126230400,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2145916800,0,&dt,&error);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68256000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(94694400,0,&dt,&error);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-63158401,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(126230399,0,&dt,&error);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(126230400,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(136252800,0,&dt,&error);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(252460800,0,&dt,&error);
	XCTAssertEqual(dt.year,1978);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(94694399,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-63158400,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(63158400,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(0,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(2851200,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,3);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(31449600,0,&dt,&error);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536000,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(63071999,0,&dt,&error);
	XCTAssertEqual(dt.year,1971);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(230947200,0,&dt,&error);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(65318400,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68083200,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68169600,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,29);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68256000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(73180800,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(220924800,0,&dt,&error);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(956793600,0,&dt,&error);
	XCTAssertEqual(dt.year,2000);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1009756799,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(1009670400,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1009843199,0,&dt,&error);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(199411200,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(191548800,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(220838400,0,&dt,&error);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(2147483647,0,&dt,&error);
	XCTAssertEqual(dt.year,2038);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,19);
	XCTAssertEqual(dt.hour,3);
	XCTAssertEqual(dt.minute,14);
	XCTAssertEqual(dt.second,7);
	
	SH_timestampToDt(63072000,0,&dt,&error);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536000,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-384780,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536001,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-31920780,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-63543180,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-91191180,0,&dt,&error);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,10);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-95079180,0,&dt,&error);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-126615180,0,&dt,&error);
	XCTAssertEqual(dt.year,1965);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-189773580,0,&dt,&error);
	XCTAssertEqual(dt.year,1963);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-86400,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-86401,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-1,0,&dt,&error);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-53049600,0,&dt,&error);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2208988800,0,&dt,&error);
	XCTAssertEqual(dt.year,1900);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4107542400,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102444800,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4133980799,0,&dt,&error);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165430399,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165344000,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4165430400,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4165516799,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165516800,0,&dt,&error);
	XCTAssertEqual(dt.year,2102);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4260124800,0,&dt,&error);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4260211199,0,&dt,&error);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4260211200,0,&dt,&error);
	XCTAssertEqual(dt.year,2105);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102358399,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4102358400,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102444799,0,&dt,&error);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4133980800,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4139078400,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4138992000,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4134067200,0,&dt,&error);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7289654400,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7289740800,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7294752000,0,&dt,&error);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(10445328000,0,&dt,&error);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(10445414400,0,&dt,&error);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(13569465600,0,&dt,&error);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(13601087999,0,&dt,&error);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(13601088000,0,&dt,&error);
	XCTAssertEqual(dt.year,2401);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2208988801,0,&dt,&error);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-2240524800,0,&dt,&error);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-8520336001,0,&dt,&error);
	XCTAssertEqual(dt.year,1699);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11644473601,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11673417601,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11676009602,0,&dt,&error);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,58);
	
	SH_timestampToDt(-11676096001,0,&dt,&error);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11707632000,0,&dt,&error);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-11802240001,0,&dt,&error);
	XCTAssertEqual(dt.year,1596);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-14831769601,0,&dt,&error);
	XCTAssertEqual(dt.year,1499);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(253402300799,0,&dt,&error);
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
	SHError error;
	memset(&error, 0, sizeof(SHError));
	double timestamp = shDtToTimestamp(&dt,&error);
	
	dt.year = 9999;
	dt.month = 12;
	dt.day = 31;
	dt.hour = 23;
	dt.minute = 59;
	dt.second = 59;
	timestamp = shDtToTimestamp(&dt,&error);
	XCTAssertEqualWithAccuracy(253402300799.096,timestamp,precision);
	
	SH_timestampToDt(253402300799.096025,0,&dt,&error);
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
	SHError error;
	memset(&error, 0, sizeof(error));
	
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
	SHError error;
	memset(&error,0,sizeof(SHError));
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
		{3,11,2,0,SH_HOUR_IN_SECONDS,{0}},
		{11,4,2,0,0,{0}}
	};
	SHError error;
	memset(&error,0,sizeof(SHError));
	SHDatetime dt = {.year = 2018,.month = 3, .day = 9, .timezoneOffset = -5*SH_HOUR_IN_SECONDS,
		.hour = 2, .minute = 13, .second = 0
	};
	

	dt.shifts = dst;
	dt.shiftLen = sizeof(dst)/sizeof(SHTimeshift);
	dt.currentShiftIdx = SH_selectTimeShiftIdxForDt(&dt,dst,dt.shiftLen);
	SHDatetime copy = dt;
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-4);
	dt.hour = 1;
	copy = dt;
	
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,13);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-5);
	dt.hour = 1;
	dt.minute = 59;
	copy = dt;
	
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,59);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-5);
	dt.hour = 2;
	dt.minute = 0;
	copy = dt;
	
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,0);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-4);
	
	dt.hour = 3;
	dt.minute = 1;
	copy = dt;
	
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,11);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-4);
	
	copy = dt;
	
	dt.hour = 6;
	SH_addDaysToDt(&copy,3,0,&error);
	XCTAssertEqual(copy.day,12);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS*-4);
	
	dt.timezoneOffset = -4 * SH_HOUR_IN_SECONDS;
	dt.month = 11;
	dt.day = 3;
	dt.hour = 0;
	dt.minute = 1;
	dt.currentShiftIdx = SH_selectTimeShiftIdxForDt(&dt,dst,dt.shiftLen);
	copy = dt;
	
	SH_addDaysToDt(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,0);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS * -4);
	
	dt.hour = 2;
	copy = dt;
	
	SH_addDaysToDt(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,1);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS * -5);
	
	dt.hour = 3;
	copy = dt;
	
	SH_addDaysToDt(&copy,1,0,&error);
	XCTAssertEqual(copy.day,4);
	XCTAssertEqual(copy.hour,3);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS * -5);
	
	dt.hour = 2;
	copy = dt;
	
	SH_addDaysToDt(&copy,2,0,&error);
	XCTAssertEqual(copy.day,5);
	XCTAssertEqual(copy.hour,2);
	XCTAssertEqual(copy.minute,1);
	XCTAssertEqual(copy.timezoneOffset,SH_HOUR_IN_SECONDS * -5);
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
	XCTAssertEqual(testDate.timeIntervalSince1970,7200);
}


-(void)testTimeOfDayInPreferredFormat{
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
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


-(void)testCalcWeekStart {
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:15 minute:32 second:17];
	NSDate *expectedDate = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	NSDate *resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:25 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:26 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:29 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:29 hour:23 minute:59 second:59];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:30 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcWeekStart];
	expectedDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	resultDate = [testDate SH_calcWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
}


-(void)testCalcNextWeekStart {
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	NSDate *testDate = [NSDate createDateTimeWithYear:1988 month:4 day:27 hour:15 minute:32 second:17];
	NSDate *expectedDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	NSDate *resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:25 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:26 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:28 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:29 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:29 hour:23 minute:59 second:59];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:4 day:30 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:15 minute:32 second:17];
	resultDate = [testDate SH_calcNextWeekStart];
	expectedDate = [NSDate createDateTimeWithYear:1988 month:5 day:8 hour:0 minute:0 second:0];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
	
	testDate = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	resultDate = [testDate SH_calcNextWeekStart];
	XCTAssertEqual(resultDate.timeIntervalSince1970, expectedDate.timeIntervalSince1970);
}


-(void)testSameWeekAs {
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	NSDate *testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	NSDate *testDate2 = [NSDate createDateTimeWithYear:1988 month:4 day:30 hour:23 minute:59 second:59];
	BOOL result = [testDate1 SH_isSameWeekAs:testDate2];
	XCTAssertTrue(result);
	result = [testDate2 SH_isSameWeekAs:testDate1];
	XCTAssertTrue(result);
	
	NSDate *testDateAfterWeek = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	result = [testDate2 SH_isSameWeekAs:testDateAfterWeek];
	XCTAssertTrue(!result);
	result = [testDateAfterWeek SH_isSameWeekAs:testDate2];
	XCTAssertTrue(!result);
	result = [testDate1 SH_isSameWeekAs:testDateAfterWeek];
	XCTAssertTrue(!result);
	result = [testDateAfterWeek SH_isSameWeekAs:testDate1];
	XCTAssertTrue(!result);
	
	NSDate *testDateBeforeWeek = [NSDate createDateTimeWithYear:1988 month:4 day:23 hour:23 minute:59 second:59];
	XCTAssertTrue(!result);
	result = [testDateBeforeWeek SH_isSameWeekAs:testDate2];
	XCTAssertTrue(!result);
	result = [testDate1 SH_isSameWeekAs:testDateBeforeWeek];
	XCTAssertTrue(!result);
	result = [testDateBeforeWeek SH_isSameWeekAs:testDate1];
	XCTAssertTrue(!result);
	
	result = [testDateBeforeWeek SH_isSameWeekAs:testDateAfterWeek];
	XCTAssertTrue(!result);
	result = [testDateAfterWeek SH_isSameWeekAs:testDateBeforeWeek];
	XCTAssertTrue(!result);
}


-(void)testWeeksBetween {
	NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
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
	NSDate *testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	NSDate *testDate2 = [NSDate createDateTimeWithYear:1988 month:4 day:30 hour:23 minute:59 second:59];
	NSInteger result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 0);
	NSTimeInterval diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:23 hour:23 minute:59 second:59];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 0);
	diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:23 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 0);
	diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:19 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 0);
	diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:1];
	XCTAssertEqual(result, 0);
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:2];
	XCTAssertEqual(result, 0);
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:3];
	XCTAssertEqual(result, 1);
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:4];
	XCTAssertEqual(result, 1);
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:5];
	XCTAssertEqual(result, 1);
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:6];
	XCTAssertEqual(result, 1);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:4 day:29 hour:23 minute:59 second:58];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:6];
	XCTAssertEqual(result, 0);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:4 day:30 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2 withWeekStartOffset:6];
	XCTAssertEqual(result, 1);
	
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:24 hour:0 minute:0 second:0];
	testDate2 = [NSDate createDateTimeWithYear:1988 month:5 day:1 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 0);
	diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:23 hour:23 minute:59 second:59];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 1);
	diff = testDate2.timeIntervalSince1970 - testDate1.timeIntervalSince1970;
	NSLog(@"%f",diff);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:5 day:7 hour:23 minute:59 second:59];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 1);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:5 day:8 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 2);
	
	testDate1 = [NSDate createDateTimeWithYear:1988 month:4 day:19 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 2);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:6 day:5 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 6);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:6 day:8 hour:0 minute:0 second:0];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 6);
	
	testDate2 = [NSDate createDateTimeWithYear:1988 month:6 day:4 hour:23 minute:59 second:59];
	result = [NSDate SH_fullWeeksBetween:testDate1 to:testDate2];
	XCTAssertEqual(result, 5);
}


-(void)testGetDayOfWeekOffsetted {
	NSDate *sun = [NSDate createSimpleDateWithYear:2018 month:1 day:7];
	NSDate *mon = [NSDate createSimpleDateWithYear:2018 month:1 day:8];
	NSDate *tue = [NSDate createSimpleDateWithYear:2018 month:1 day:9];
	NSDate *wed = [NSDate createSimpleDateWithYear:2018 month:1 day:10];
	NSDate *thurs = [NSDate createSimpleDateWithYear:2018 month:1 day:11];
	NSDate *fri = [NSDate createSimpleDateWithYear:2018 month:1 day:12];
	NSDate *sat = [NSDate createSimpleDateWithYear:2018 month:1 day:13];
	NSUInteger offset = 0;
	NSUInteger result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);

	offset = 1;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	
	offset = 2;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	
	offset = 3;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	
	offset = 4;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	
	offset = 5;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	
	offset = 6;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	
	offset = 7;
	result = [sun SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 0);
	result = [mon SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 1);
	result = [tue SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 2);
	result = [wed SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 3);
	result = [thurs SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 4);
	result = [fri SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 5);
	result = [sat SH_getWeekdayIndexOffsetForStartDayIdx:offset];
	XCTAssertEqual(result, 6);
}

@end
