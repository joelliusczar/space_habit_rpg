//
//  TestsTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ARCTest.h"
#import "TestKeepSubject_A.h"


@interface TestsTest : XCTestCase

@end

@implementation TestsTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSomeArcStuff{
    ARCTest *arcTest = [ARCTest new];
    TestKeepSubject_A *subA = [TestKeepSubject_A new];
    arcTest.subA = subA;
    subA = nil;
    XCTAssertNil(arcTest.subA);
}

@end
