//
//  TestDailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DailyHelper.h"
#import "CommonUtilitiesMock.h"
#import "constants.h"

@interface TestDailyHelper : XCTestCase
@property (nonatomic,strong) DailyHelper *helper;
@property (nonatomic,strong) NSMutableArray *switches;
@end

@implementation TestDailyHelper

- (void)setUp {
    [super setUp];
    self.helper = [[DailyHelper alloc]init];
    self.helper.commonHelper = [[CommonUtilitiesMock alloc]init];
    self.switches =  [NSMutableArray arrayWithCapacity:DAYS_IN_WEEK];
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        [self.switches addObject:[NSMutableString stringWithFormat:@"NO"]];
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCalculateActiveDaysHash {
    int result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 0);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 1);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 2);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 3);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 4);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:3 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 8);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:3 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:4 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 16);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:3 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:4 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:5 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 32);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:3 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:4 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:5 withObject:[NSMutableString stringWithFormat:@"NO"]];
    [self.switches replaceObjectAtIndex:6 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 64);
    [self.switches replaceObjectAtIndex:0 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:1 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:2 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:3 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:4 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:5 withObject:[NSMutableString stringWithFormat:@"YES"]];
    [self.switches replaceObjectAtIndex:6 withObject:[NSMutableString stringWithFormat:@"YES"]];
    result = [self.helper calculateActiveDaysHash:self.switches];
    XCTAssertEqual(result, 127);

}

-(void)testSetActiveDaySwitches{
    [self.helper setActiveDaySwitches:self.switches fromHash:0];
    int i = 0;
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:1];
    i = 0;
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:2];
    i = 0;
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:4];
    i = 0;
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:8];
    i = 0;
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:3];
    i = 0;
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertFalse([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    
    [self.helper setActiveDaySwitches:self.switches fromHash:127];
    i = 0;
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
    XCTAssertTrue([[self.switches objectAtIndex:i++] isEqual:@"YES"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
