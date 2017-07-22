//
//  MathTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHMath.h"

@interface MathTest : XCTestCase

@end

@implementation MathTest

-(void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

-(void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testIsPowerOfTwo{
    for(int i = 0;i<5000;i++){
        BOOL pow2 = i==1||i==2||i==4||i==8||i==16||i==32||i==64||i==128||i==256||i==512
        ||i==1024||i==2048||i==4096;
        BOOL pow2Call = [SHMath isPowerOfTwo:i];
        XCTAssertEqual(pow2,pow2Call);
    }
}

@end
