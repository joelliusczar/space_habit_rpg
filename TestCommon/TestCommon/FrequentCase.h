//
//  FrequentCase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import "TestHelpers.h"
#import "TestGlobals.h"
#import "TestDummy.h"



@interface FrequentCase : XCTestCase
-(void)resetDb;

-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context;

@end
