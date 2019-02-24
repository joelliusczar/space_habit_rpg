//
//  FrequentCase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <SHModels/SingletonCluster+Entity.h>
#import "TestHelpers.h"
#import "TestGlobals.h"


@interface FrequentCase : XCTestCase
-(void)resetDb;

-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
dataController:(NSObject<P_CoreData>*) dataController;

@end
