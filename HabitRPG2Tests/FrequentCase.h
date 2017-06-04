//
//  FrequentCase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TestHelpers.h"
#import "TestGlobals.h"
#import "SingletonCluster.h"

@interface FrequentCase : XCTestCase
@property (strong,nonatomic) NSManagedObjectContext *testContext;
@end
