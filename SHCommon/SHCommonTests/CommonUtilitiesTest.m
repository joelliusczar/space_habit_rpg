//
//  CommonUtilitiesTest.m
//  SHCommonTests
//
//  Created by Joel Pridgen on 5/2/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;

@interface CommonUtilitiesTest : XCTestCase

@end

@implementation CommonUtilitiesTest


- (void)setUp {
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


NSDate* getReferenceDate(){
	NSCalendar *cal = NSCalendar.SH_appCalendar;
	NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
	dateComponents.year = 2016;
	dateComponents.month = 1;
	dateComponents.day = 1;
	dateComponents.hour = 0;
	dateComponents.minute = 0;
	dateComponents.second = 0;
	
	return [cal dateFromComponents:dateComponents];
}


-(void)testGetReferenceDate{
	NSDate *d = getReferenceDate();
	XCTAssertTrue([[d description] isEqualToString:@"2016-01-01 05:00:00 +0000"]);
}


-(void)testJsonStuff{
	NSMutableDictionary *testDict = [NSMutableDictionary dictionary];
	testDict[@"SAT"] = @1;
	testDict[@"MON"] = @1;
	
	NSString *testJson = [testDict dictToString];
	NSMutableDictionary *testDict2 = [NSMutableDictionary jsonStringToDict:testJson];
	XCTAssertEqual(((NSNumber *)testDict2[@"SAT"]).integerValue,1);
	[testDict2 removeObjectForKey:@"MON"];
	testDict2[@"THR"] = @1;
	
	NSString *testJson2 = [testDict2 dictToString];
	NSMutableDictionary *testDict3 = [NSMutableDictionary jsonStringToDict:testJson2];
	XCTAssertEqual(((NSNumber *)testDict3[@"THR"]).integerValue,1);
	XCTAssertNil(testDict3[@"MON"]);
	
	
}




@end
