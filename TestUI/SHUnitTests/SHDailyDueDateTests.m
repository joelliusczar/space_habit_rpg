//
//  SHDailyDueDateTests.m
//  SHTests
//
//  Created by Joel Pridgen on 3/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;
@import SHTestCommon;
@import SHModels;

@interface SHDailyDueDateTests : FrequentCase
@property (strong, nonatomic, nonnull) SHActiveDaysProvider *activeDaysProvider;
@end

@implementation SHDailyDueDateTests

- (void)setUp {
	[super setUp];
	self.activeDaysProvider = [[SHActiveDaysProvider alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	[super tearDown];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testDaysAgo {
	int64_t daysAgo = sh_calcDaysAgoDayWasActive(0,3);
	XCTAssertEqual(daysAgo, 21);
	daysAgo = sh_calcDaysAgoDayWasActive(0,2);
	XCTAssertEqual(daysAgo, 14);
}

-(void)testTuesWedThursSat {
	SHDailyActiveDays *activeDays = [self.activeDaysProvider tuesWedThursSat];
	
	SHDailyNextDueDateCalculator *calc = [[SHDailyNextDueDateCalculator alloc]
		initWithActiveDays:activeDays
		lastActivationDateTime:nil
		lastUpdateDateTime:[NSDate createDateTimeWithYear:2020
		month:3
		day:8
		hour:0
		minute:0
		second:0]
		dayStartTime:0];
		
	NSDate *backupDate = [calc calcBackupLastCheckinDate];
	NSDate *expected = [NSDate createDateTimeWithYear:2020
		month:3
		day:7
		hour:0
		minute:0
		second:0];
	XCTAssertEqual(backupDate.timeIntervalSince1970, expected.timeIntervalSince1970);
	activeDays.weeklyActiveDays.intervalSize = 3;
	backupDate = [calc calcBackupLastCheckinDate];
	expected = [NSDate createDateTimeWithYear:2020
	month:2
	day:29
	hour:0
	minute:0
	second:0];
}


@end
