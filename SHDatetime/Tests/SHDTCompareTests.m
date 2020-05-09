//
//  SHDTCompareTests.m
//  SHDatetimeTests
//
//  Created by Joel Pridgen on 5/8/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHDatetime;

@interface SHDTCompareTests : XCTestCase

@end

@implementation SHDTCompareTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testEqualDifferentTimezone {
	struct SHDatetime A = {.year = 2020, .month = 5, .day = 8, .hour = 5};
	struct SHDatetime B = {.year = 2020, .month = 5, .day = 8, .hour = 1, .timezoneOffset = -14400};
	bool result = false;
	SH_areDatesEqual(&A, &B, &result);
	XCTAssertTrue(result);
}

@end
