//
//  FrequentCase.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"

@implementation FrequentCase

-(void)setUp{
    [super setUp];
    ASSERT_IS_TEST();
    self.testContext = [SHData constructContext:NSMainQueueConcurrencyType];
    SHData.inUseContext = self.testContext;
    [TestHelpers resetCoreData:SHData.inUseContext];
    [SHData initializeCoreData];
}

-(void)tearDown{
    self.testContext = nil;
    SHData.inUseContext = nil;
    [super tearDown];
}

@end
