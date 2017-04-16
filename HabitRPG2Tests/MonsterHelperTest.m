//
//  MonsterHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SingletonCluster.h"
#import "MonsterHelper.h"
#import "Monster+CoreDataClass.h"
#import "MockStdLibWrapper.h"
#import "TestGlobals.h"

#define SET_UP_BOUND() shouldUseLowerBoundChoices_mh[i++] = NO
#define SET_LOW_BOUND() shouldUseLowerBoundChoices_mh[i++] = YES

@interface MonsterHelperTest : XCTestCase

@end

MockStdLibWrapper *mw_mh;
BOOL shouldUseLowerBoundChoices_mh[25];
int rIdx_mh;

@implementation MonsterHelperTest

- (void)setUp {
    [super setUp];
    ASSERT_IS_TEST();
    mw_mh = [[MockStdLibWrapper alloc] init];
    [SingletonCluster getSharedInstance].stdLibWrapper =mw_mh;
    mw_mh.mockRandom = ^uint(uint range){
        return shouldUseLowerBoundChoices_mh[rIdx_mh++]?0:(range-1);
    };
    DELETE_ALL();
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
