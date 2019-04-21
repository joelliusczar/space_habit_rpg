//
//  ProbilityWeightTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/SHProbWeight.h>
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHCommonUtils.h>
@import SHTestCommon;

@interface ProbilityWeightTest : XCTestCase

@end

int rIdx_pw = 0;

uint probWeight_mockRandom(uint range){
    int answer = rIdx_pw%range;
    rIdx_pw++;
    return answer;
}


@implementation ProbilityWeightTest

    -(void)setUp {
        [super setUp];
        ASSERT_IS_TEST();
        rIdx_pw = 0;
        shRandomUInt = &probWeight_mockRandom;
    }
    
    -(void)testZeroItems{
        SHProbWeight *pw0 = [[SHProbWeight alloc]init];
        XCTAssertThrows([pw0 weightedRandomKey]);
        XCTAssertThrows([pw0 add:@"A" With:0]);
        XCTAssertThrows([pw0 add:@"" With:1]);
        XCTAssertNoThrow([pw0 add:@"   " With:1]);
    }
    
    -(void)testOneItem{
        SHProbWeight *pw1 = [[SHProbWeight alloc]init];
        [pw1 add:@"A" With:4];

        NSString *s = [pw1 weightedRandomKey];
        XCTAssertTrue([s isEqualToString:@"A"]);
        
        s = [pw1 weightedRandomKey];
        XCTAssertTrue([s isEqualToString:@"A"]);
        
        s = [pw1 weightedRandomKey];
        XCTAssertTrue([s isEqualToString:@"A"]);
        
        s = [pw1 weightedRandomKey];
        XCTAssertTrue([s isEqualToString:@"A"]);
        
    }
    
    -(void)testTwoItems{
        SHProbWeight *pw = [[SHProbWeight alloc] init];
        NSString *s =@"";
        
        [pw add:@"A" With:1];
        [pw add:@"B" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:2];
        [pw add:@"B" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:3];
        [pw add:@"B" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:4];
        [pw add:@"B" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:5];
        [pw add:@"B" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:6];
        [pw add:@"B" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:7];
        [pw add:@"B" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:8];
        [pw add:@"B" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        
        
        pw = [[SHProbWeight alloc] init];
        
        [pw add:@"A" With:9];
        [pw add:@"B" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);

    }
    
    -(void)testExactlyThreeItems{
        SHProbWeight *pw = [[SHProbWeight alloc] init];
        NSString *s =@"";
        
        [pw add:@"A" With:1];
        [pw add:@"B" With:1];
        [pw add:@"C" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }



@end
