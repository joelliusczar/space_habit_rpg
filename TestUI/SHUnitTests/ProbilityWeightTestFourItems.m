//
//  ProbilityWeightTestFourItems.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHCommon/SHProbWeight.h>
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHCommonUtils.h>
@import SHTestCommon;

@interface ProbilityWeightTestFourItems : XCTestCase

@end

int rIdx_pw4 = 0;

uint probWeight4_mockRandom(uint range){
    int answer = rIdx_pw4%range;
    rIdx_pw4++;
    return answer;
}


@implementation ProbilityWeightTestFourItems

    -(void)setUp {
        [super setUp];
        ASSERT_IS_TEST();
        rIdx_pw4 = 0;
        shRandomUInt = &probWeight4_mockRandom;
    }
    
    -(void)testPW1{
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
        SHProbWeight *pw = [[SHProbWeight alloc] init];
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
