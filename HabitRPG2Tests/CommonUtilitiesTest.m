//
//  CommonUtilitiesTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CommonUtilities.h"
#import "MockStdLibWrapper.h"
#import "SingletonCluster.h"

@interface CommonUtilitiesTest : XCTestCase

@end

MockStdLibWrapper *mw2;
BOOL shouldUseLowerBound =YES;

@implementation CommonUtilitiesTest
    
    - (void)setUp {
        [super setUp];
        XCTAssertEqual([SingletonCluster getSharedInstance].EnviromentNum,ENV_UTEST);
        mw2 = [[MockStdLibWrapper alloc] init];
        [SingletonCluster getSharedInstance].stdLibWrapper =mw2;
        mw2.mockRandom = ^uint(uint bound){
            return shouldUseLowerBound?0:(bound-1);
        };
    }
    
    -(void)testGetReferenceDate{
        NSDate *d = [CommonUtilities getReferenceDate];
        XCTAssertTrue([[d description] isEqualToString:@"2016-01-01 05:00:00 +0000"]);
    }
    
    -(void)testCalculateLvl{
        uint offset = 10;
        
        uint lvl = 0;
        shouldUseLowerBound = YES;
        int result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 11);
        lvl = 1;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 11);
        lvl = 2;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 12);
        lvl = 5;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 15);
        lvl = 9;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 19);
        lvl = 10;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 20);
        lvl = 11;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 1);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 21);
        lvl = 12;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 2);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 22);
        lvl = 15;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 5);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 25);
        lvl = 55;
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 45);
        shouldUseLowerBound = !shouldUseLowerBound;
        result = [CommonUtilities calculateLvl:lvl OffsetBy:offset];
        XCTAssertEqual(result, 65);
        
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }

    - (void)testExample {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    - (void)testPerformanceExample {
        // This is an example of a performance test case.
        [self measureBlock:^{
            // Put the code you want to measure the time of here.
        }];
    }

@end
