//
//  SHTimestampToDtTests.m
//  SHDatetimeTests
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHDatetime;

@interface SHTimestampToDtTests : XCTestCase

@end

@implementation SHTimestampToDtTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testTimestampToDateObj{
	struct SHDatetime dt;


	
	SH_timestampToDt(-2051222400,0,&dt);
	XCTAssertEqual(dt.year,1905);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2082844800,0,&dt);
	XCTAssertEqual(dt.year,1904);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-126230399,0,&dt);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(-2145916799,0,&dt);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(157766399,0,&dt);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-126230400,0,&dt);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2145916800,0,&dt);
	XCTAssertEqual(dt.year,1902);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68256000,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(94694400,0,&dt);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-63158401,0,&dt);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(126230399,0,&dt);
	XCTAssertEqual(dt.year,1973);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(126230400,0,&dt);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(136252800,0,&dt);
	XCTAssertEqual(dt.year,1974);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(252460800,0,&dt);
	XCTAssertEqual(dt.year,1978);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(94694399,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-63158400,0,&dt);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(63158400,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(0,0,&dt);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1,0,&dt);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,1);
	
	SH_timestampToDt(2851200,0,&dt);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,3);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(31449600,0,&dt);
	XCTAssertEqual(dt.year,1970);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536000,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(63071999,0,&dt);
	XCTAssertEqual(dt.year,1971);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(230947200,0,&dt);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(65318400,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68083200,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68169600,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,29);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(68256000,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(73180800,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(220924800,0,&dt);
	XCTAssertEqual(dt.year,1977);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(956793600,0,&dt);
	XCTAssertEqual(dt.year,2000);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1009756799,0,&dt);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(1009670400,0,&dt);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(1009843199,0,&dt);
	XCTAssertEqual(dt.year,2001);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(199411200,0,&dt);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(191548800,0,&dt);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(220838400,0,&dt);
	XCTAssertEqual(dt.year,1976);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(2147483647,0,&dt);
	XCTAssertEqual(dt.year,2038);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,19);
	XCTAssertEqual(dt.hour,3);
	XCTAssertEqual(dt.minute,14);
	XCTAssertEqual(dt.second,7);
	
	SH_timestampToDt(63072000,0,&dt);
	XCTAssertEqual(dt.year,1972);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536000,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-384780,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-31536001,0,&dt);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-31920780,0,&dt);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-63543180,0,&dt);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-91191180,0,&dt);
	XCTAssertEqual(dt.year,1967);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,10);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-95079180,0,&dt);
	XCTAssertEqual(dt.year,1966);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-126615180,0,&dt);
	XCTAssertEqual(dt.year,1965);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-189773580,0,&dt);
	XCTAssertEqual(dt.year,1963);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,13);
	XCTAssertEqual(dt.minute,7);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-86400,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-86401,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-1,0,&dt);
	XCTAssertEqual(dt.year,1969);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-53049600,0,&dt);
	XCTAssertEqual(dt.year,1968);
	XCTAssertEqual(dt.month,4);
	XCTAssertEqual(dt.day,27);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2208988800,0,&dt);
	XCTAssertEqual(dt.year,1900);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4107542400,0,&dt);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102444800,0,&dt);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4133980799,0,&dt);
	XCTAssertEqual(dt.year,2100);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165430399,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165344000,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4165430400,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4165516799,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4165516800,0,&dt);
	XCTAssertEqual(dt.year,2102);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4260124800,0,&dt);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4260211199,0,&dt);
	XCTAssertEqual(dt.year,2104);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4260211200,0,&dt);
	XCTAssertEqual(dt.year,2105);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102358399,0,&dt);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,30);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4102358400,0,&dt);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4102444799,0,&dt);
	XCTAssertEqual(dt.year,2099);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(4133980800,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4139078400,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4138992000,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,2);
	XCTAssertEqual(dt.day,28);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(4134067200,0,&dt);
	XCTAssertEqual(dt.year,2101);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7289654400,0,&dt);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7289740800,0,&dt);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(7294752000,0,&dt);
	XCTAssertEqual(dt.year,2201);
	XCTAssertEqual(dt.month,3);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(10445328000,0,&dt);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(10445414400,0,&dt);
	XCTAssertEqual(dt.year,2301);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,2);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(13569465600,0,&dt);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(13601087999,0,&dt);
	XCTAssertEqual(dt.year,2400);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(13601088000,0,&dt);
	XCTAssertEqual(dt.year,2401);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-2208988801,0,&dt);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-2240524800,0,&dt);
	XCTAssertEqual(dt.year,1899);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-8520336001,0,&dt);
	XCTAssertEqual(dt.year,1699);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11644473601,0,&dt);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11673417601,0,&dt);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11676009602,0,&dt);
	XCTAssertEqual(dt.year,1600);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,58);
	
	SH_timestampToDt(-11676096001,0,&dt);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-11707632000,0,&dt);
	XCTAssertEqual(dt.year,1599);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,0);
	XCTAssertEqual(dt.minute,0);
	XCTAssertEqual(dt.second,0);
	
	SH_timestampToDt(-11802240001,0,&dt);
	XCTAssertEqual(dt.year,1596);
	XCTAssertEqual(dt.month,1);
	XCTAssertEqual(dt.day,1);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(-14831769601,0,&dt);
	XCTAssertEqual(dt.year,1499);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
	
	SH_timestampToDt(253402300799,0,&dt);
	XCTAssertEqual(dt.year,9999);
	XCTAssertEqual(dt.month,12);
	XCTAssertEqual(dt.day,31);
	XCTAssertEqual(dt.hour,23);
	XCTAssertEqual(dt.minute,59);
	XCTAssertEqual(dt.second,59);
}


int64_t calcDaysFromBase(int64_t span){
	struct SHDatetime base = { .year = 2017, .month = 1, .day = 7, .timezoneOffset = -18000};
	struct SHDatetime adjusted = base;
	SH_addDaysToDt(&adjusted, span, SH_TIME_ADJUST_NO_OPTION);
	int64_t dayDiff = 0;
	SH_dateDiffDays(&base, &adjusted, &dayDiff);
	return dayDiff;
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

@end
