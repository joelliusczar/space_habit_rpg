//
//  SHWeeklyDueDateCalculatorTests.m
//  SHModelsTests
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHDailyNextWeeklyDueDateCalculator.h"
@import SHTestCommon;
@import SHSpecial_C;

@interface SHWeeklyDueDateCalculatorTests : FrequentCase
@property (strong, nonatomic, nonnull) SHActiveDaysProvider *activeDaysProvider;
@end

@implementation SHWeeklyDueDateCalculatorTests

-(void)setUp {
		self.activeDaysProvider = [[SHActiveDaysProvider alloc] init];
		// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
}


@end
