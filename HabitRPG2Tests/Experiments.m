//
//  Experiments.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Experiments : XCTestCase

@end

@implementation Experiments

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConvertToMutableArray{
    NSArray *a = @[@"a",@"b",@"c"];
    NSMutableArray *m = [NSMutableArray arrayWithArray:a];
    NSMutableArray *mm = [a mutableCopy];
    [m replaceObjectAtIndex:0 withObject:@"z"];
    NSString *mm1 = [mm objectAtIndex:0];
    XCTAssertEqual(mm1, @"a");
    NSString *a1 = [a objectAtIndex:0];
    XCTAssertEqual(a1, @"a");
    [mm replaceObjectAtIndex:0 withObject:@"z"];
    a1 = [a objectAtIndex:0];
    XCTAssertEqual(a1, @"a");

}


-(void)testNilsAndNumbers{
    id a = nil;
    NSNumber *n = (NSNumber*)a;
    NSUInteger iu = n.unsignedIntegerValue;
    XCTAssertEqual(iu, 0);
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
