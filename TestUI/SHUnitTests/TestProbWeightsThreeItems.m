//
//  TestSHProbWeightsThreeItems.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;

@import SHTestCommon;

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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:1];
	[pw add:@"A" with:13];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:2];
	[pw add:@"A" with:12];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:3];
	[pw add:@"A" with:11];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:4];
	[pw add:@"A" with:10];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:5];
	[pw add:@"A" with:9];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:6];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:7];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:8];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:9];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:10];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:11];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:12];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:1];
	[pw add:@"B" with:13];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:1];
	[pw add:@"A" with:12];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:2];
	[pw add:@"A" with:11];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:3];
	[pw add:@"A" with:10];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:4];
	[pw add:@"A" with:9];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:5];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:6];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:7];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:8];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:9];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:10];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:11];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:2];
	[pw add:@"B" with:12];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:1];
	[pw add:@"A" with:11];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:2];
	[pw add:@"A" with:10];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:3];
	[pw add:@"A" with:9];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:4];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:5];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:6];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:7];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:8];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:9];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:10];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:3];
	[pw add:@"B" with:11];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:1];
	[pw add:@"A" with:10];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:2];
	[pw add:@"A" with:9];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:3];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:4];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:5];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:6];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:7];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:8];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:9];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:4];
	[pw add:@"B" with:10];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:1];
	[pw add:@"A" with:9];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:2];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:3];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:4];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:5];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:6];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:7];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:8];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:5];
	[pw add:@"B" with:9];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:1];
	[pw add:@"A" with:8];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:2];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:3];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:4];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:5];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:6];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:7];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:6];
	[pw add:@"B" with:8];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:1];
	[pw add:@"A" with:7];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:2];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:3];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:4];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:5];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:6];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:7];
	[pw add:@"B" with:7];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:1];
	[pw add:@"A" with:6];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:2];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:3];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:4];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:5];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:8];
	[pw add:@"B" with:6];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:9];
	[pw add:@"B" with:1];
	[pw add:@"A" with:5];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:9];
	[pw add:@"B" with:2];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:9];
	[pw add:@"B" with:3];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:9];
	[pw add:@"B" with:4];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:9];
	[pw add:@"B" with:5];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:10];
	[pw add:@"B" with:1];
	[pw add:@"A" with:4];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:10];
	[pw add:@"B" with:2];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:10];
	[pw add:@"B" with:3];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:10];
	[pw add:@"B" with:4];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:11];
	[pw add:@"B" with:1];
	[pw add:@"A" with:3];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:11];
	[pw add:@"B" with:2];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:11];
	[pw add:@"B" with:3];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:12];
	[pw add:@"B" with:1];
	[pw add:@"A" with:2];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:12];
	[pw add:@"B" with:2];
	[pw add:@"A" with:1];
	
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
	SHProbWeight *pw = [[SHProbWeight alloc] init];
	NSString *s = @"";
	[pw add:@"C" with:13];
	[pw add:@"B" with:1];
	[pw add:@"A" with:1];
	
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
