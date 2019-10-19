//
//	SHTestObserver.m
//	TestUI
//
//	Created by Joel Pridgen on 2/28/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHTestObserver.h"

@implementation SHTestObserver

-(instancetype)init{
	if(self = [super init]){
		XCTestObservationCenter* center = XCTestObservationCenter.sharedTestObservationCenter;
		[center addTestObserver:self];
	}
	return self;
}

-(void)testBundleWillStart:(NSBundle *)testBundle{
	(void)testBundle;
}

-(void)testSuiteWillStart:(XCTestSuite *)testSuite{
	(void)testSuite;
}


-(void)testCaseWillStart:(XCTestCase *)testCase{
	(void)testCase;
}


-(void)testCaseDidFinish:(XCTestCase *)testCase{
	(void)testCase;
}


-(void)testSuiteDidFinish:(XCTestSuite *)testSuite{
	(void)testSuite;
}

-(void)testBundleDidFinish:(NSBundle *)testBundle{
	(void)testBundle;
}

@end
