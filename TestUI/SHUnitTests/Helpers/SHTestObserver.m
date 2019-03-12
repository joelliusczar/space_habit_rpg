//
//  SHTestObserver.m
//  TestUI
//
//  Created by Joel Pridgen on 2/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
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
  NSLog(@"First");
}

-(void)testSuiteWillStart:(XCTestSuite *)testSuite{
  (void)testSuite;
  NSLog(@"Second?");
}

@end
