//
//  ProbilityWeightTestFourItems.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProbWeight.h"
#import "constants.h"
#import "TestGlobals.h"
#import "SingletonCluster.h"
#import "MockStdLibWrapper.h"

@interface ProbilityWeightTestFourItems : XCTestCase

@end

MockStdLibWrapper *mw_pw4;
int rIdx_pw4 = 0;

@implementation ProbilityWeightTestFourItems

    -(void)setUp {
        [super setUp];
        ASSERT_IS_TEST();
        rIdx_pw4 = 0;
        mw_pw4 = [[MockStdLibWrapper alloc] init];
        [SingletonCluster getSharedInstance].stdLibWrapper =mw_pw4;
        mw_pw4.mockRandom = ^uint(uint range){
            int answer = rIdx_pw4%range;
            rIdx_pw4++;
            return answer;
        };
        
    }
    
    -(void)testPW1{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:9];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW2{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:8];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW3{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:7];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW4{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:6];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW5{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW6{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW7{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW8{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW9{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:9];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW10{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:8];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW11{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:7];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW12{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:6];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW13{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:5];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW14{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW15{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW16{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW17{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW18{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:7];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW19{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:6];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW20{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:5];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW21{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:4];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW22{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW23{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW24{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW25{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:6];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW26{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:5];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW27{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:4];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW28{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:3];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW29{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW30{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW31{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:5];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW32{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:5];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW33{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:5];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW34{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:5];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW35{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW36{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:6];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW37{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:6];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW38{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:6];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW39{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:6];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW40{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:7];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW41{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:7];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW42{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:7];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW43{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:8];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW44{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:8];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW45{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:1];
        [pw add:@"C" With:9];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
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
        
    }
    
    -(void)testPW46{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:8];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW47{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:7];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW48{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:6];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW49{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW50{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW51{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW52{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW53{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:8];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW54{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:7];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW55{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:6];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW56{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:5];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW57{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW58{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW59{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW60{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW61{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:6];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW62{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:5];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW63{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:4];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW64{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW65{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW66{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW67{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:4];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW68{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:4];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW69{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:4];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW70{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW71{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW72{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:5];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW73{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:5];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW74{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:5];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW75{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW76{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:6];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW77{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:6];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW78{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:6];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW79{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:7];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW80{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:7];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW81{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:2];
        [pw add:@"C" With:8];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
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
        
    }
    
    -(void)testPW82{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:7];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW83{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:6];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW84{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW85{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW86{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW87{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW88{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:7];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW89{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:6];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW90{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:5];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW91{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW92{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW93{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW94{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW95{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:3];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW96{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:3];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW97{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW98{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW99{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW100{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:4];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW101{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:4];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW102{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW103{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW104{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:5];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW105{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:5];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW106{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW107{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:6];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW108{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:6];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW109{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:3];
        [pw add:@"C" With:7];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
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
        
    }
    
    -(void)testPW110{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:6];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW111{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW112{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW113{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW114{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW115{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:6];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW116{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:2];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW117{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW118{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW119{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW120{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW121{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:3];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW122{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW123{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW124{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW125{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:4];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW126{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW127{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW128{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:5];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW129{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW130{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:4];
        [pw add:@"C" With:6];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
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
        
    }
    
    -(void)testPW131{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:1];
        [pw add:@"B" With:5];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW132{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW133{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW134{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW135{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:5];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW136{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:2];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW137{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW138{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW139{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW140{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:3];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW141{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW142{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW143{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:4];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW144{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW145{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:5];
        [pw add:@"C" With:5];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
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
        
    }
    
    -(void)testPW146{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:1];
        [pw add:@"B" With:4];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW147{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW148{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW149{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:4];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW150{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:2];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW151{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW152{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW153{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:3];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW154{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW155{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:6];
        [pw add:@"C" With:4];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
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
        
    }
    
    -(void)testPW156{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:1];
        [pw add:@"B" With:3];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW157{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW158{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:3];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW159{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:2];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW160{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW161{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:7];
        [pw add:@"C" With:3];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
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
        
    }
    
    -(void)testPW162{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:8];
        [pw add:@"C" With:1];
        [pw add:@"B" With:2];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        
    }
    
    -(void)testPW163{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:8];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:2];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        
    }
    
    -(void)testPW164{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:8];
        [pw add:@"C" With:2];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        
    }
    
    -(void)testPW165{
        ProbWeight *pw = [[ProbWeight alloc] init];
        NSString *s = @"";
        [pw add:@"D" With:9];
        [pw add:@"C" With:1];
        [pw add:@"B" With:1];
        [pw add:@"A" With:1];
        
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//0
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//1
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//2
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//3
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//4
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//5
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//6
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//7
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"D"]);//8
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"C"]);//9
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"B"]);//10
        s = [pw weightedRandomKey];
        XCTAssert([s isEqualToString: @"A"]);//11
        
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
