//
//  TestProbWeightsThreeItems.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/SHProbWeight.h>
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHCommonUtils.h>
@import TestCommon;

@interface TestProbWeightsThreeItems: XCTestCase

@end

int rIdx_pw3 = 0;

uint probWeight3_mockRandom(uint range){
    int answer = rIdx_pw3%range;
    rIdx_pw3++;
    return answer;
}


@implementation TestProbWeightsThreeItems
    
    -(void)setUp {
        [super setUp];
        ASSERT_IS_TEST();
        rIdx_pw3 = 0;
        shRandomUInt = &probWeight3_mockRandom;
    }
    
    -(void)testPW1_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:13];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:12];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:11];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:10];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:6];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:7];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:8];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:9];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_10{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:10];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_11{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:11];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_12{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:12];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW1_13{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:1];
        [pw add:@"B" With:13];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:12];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:11];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:10];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:5];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:6];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:7];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:8];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:9];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_10{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:10];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_11{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:11];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW2_12{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:2];
        [pw add:@"B" With:12];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:11];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:10];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:4];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:5];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:6];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:7];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:8];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:9];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_10{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:10];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW3_11{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:3];
        [pw add:@"B" With:11];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:10];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:3];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:4];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:5];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:6];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:7];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:8];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:9];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW4_10{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:4];
        [pw add:@"B" With:10];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:2];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:3];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:4];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:5];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:6];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:7];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:8];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW5_9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:5];
        [pw add:@"B" With:9];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:1];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:2];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:3];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:4];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:5];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:6];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:7];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW6_8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:6];
        [pw add:@"B" With:8];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:1];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:2];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:3];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:4];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:5];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:6];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW7_7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:7];
        [pw add:@"B" With:7];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:1];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:2];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:3];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:4];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:5];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW8_6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:8];
        [pw add:@"B" With:6];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW9_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:9];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW9_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:9];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW9_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:9];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW9_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:9];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW9_5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:9];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW10_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:10];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW10_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:10];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW10_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:10];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW10_4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:10];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW11_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:11];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW11_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:11];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW11_3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:11];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW12_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:12];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW12_2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:12];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }
    
    -(void)testPW13_1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"C" With:13];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//11
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//12
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//13
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//14
        
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }
    
    
    
    @end
