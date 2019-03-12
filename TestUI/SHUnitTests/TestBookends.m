//
//  TestBookends.m
//  SHTests
//
//  Created by Joel Pridgen on 3/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <TestCommon/TestDummy.h>
#import <TestCommon/DumbCoreDataController.h>
#import <XCTest/XCTest.h>


@interface TestBookends : XCTestCase
@property (strong,nonatomic) NSObject* strongObj;
@end

@implementation TestBookends

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.strongObj = [TestDummy new];
    TestDummy* dumdum = [TestDummy extraNew];
    NSLog(@"%@",dumdum);
    //NSBundle *testBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
    DumbCoreDataController* dc = [DumbCoreDataController new];
    NSLog(@"%@",dc);
}

- (void)tearDown {
  [((TestDummy*)self.strongObj) methodWithARP];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
