//
//  ProbilityWeightTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;

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
	XCTAssertThrows([pw0 add:@"A" with:0]);
	XCTAssertThrows([pw0 add:@"" with:1]);
	XCTAssertNoThrow([pw0 add:@"   " with:1]);
}
	
-(void)testOneItem{
	SHProbWeight *pw1 = [[SHProbWeight alloc]init];
	[pw1 add:@"A" with:4];

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
	
	[pw add:@"A" with:1];
	[pw add:@"B" with:9];
	
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
	
	[pw add:@"A" with:2];
	[pw add:@"B" with:8];
	
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
	
	[pw add:@"A" with:3];
	[pw add:@"B" with:7];
	
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
	
	[pw add:@"A" with:4];
	[pw add:@"B" with:6];
	
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
	
	[pw add:@"A" with:5];
	[pw add:@"B" with:5];
	
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
	
	[pw add:@"A" with:6];
	[pw add:@"B" with:4];
	
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
	
	[pw add:@"A" with:7];
	[pw add:@"B" with:3];
	
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
	
	[pw add:@"A" with:8];
	[pw add:@"B" with:2];
	
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
	
	[pw add:@"A" with:9];
	[pw add:@"B" with:1];
	
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
	
	[pw add:@"A" with:1];
	[pw add:@"B" with:1];
	[pw add:@"C" with:1];
	
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
