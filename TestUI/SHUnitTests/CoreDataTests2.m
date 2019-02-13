//
//  CoreDataTests2.m
//  SHUnitTests
//
//  Created by Joel Pridgen on 2/4/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHData/SHData.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <TestCommon/TestHelpers.h>
@import CoreData;

@interface CoreDataTests2 : XCTestCase

@end

@implementation CoreDataTests2

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testBrokenEntities{
  NSEntityDescription* e = Zone.entity;
  XCTAssertNil(e);
  NSBundle *testBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
  CoreDataStackController* __weak weakDC = nil;
  CoreDataStackController *dc = nil;
  @autoreleasepool {
    dc = [CoreDataStackController newWithBundle:testBundle storeType:NSInMemoryStoreType];
    NSEntityDescription* e2 = Zone.entity;
    XCTAssertNotNil(e2);
    //  NSPersistentStoreCoordinator* __weak coord = (NSPersistentStoreCoordinator *)[TestHelpers getPrivateValue:dc
    //    ivarName:@"_coordinator"];
    //  NSManagedObjectModel* __weak mom = coord.managedObjectModel;
    weakDC = dc;
    dc = [CoreDataStackController newWithBundle:testBundle storeType:NSInMemoryStoreType];
    e2 = Zone.entity;
    XCTAssertNil(e2);
    NSLog(@"Doot doot doot");
  }
  
  
  NSLog(@"Doot doot doot");
  
  dc = [CoreDataStackController newWithBundle:testBundle storeType:NSInMemoryStoreType];
  e = Zone.entity;
  XCTAssertNotNil(e);
//  coord = (NSPersistentStoreCoordinator *)[TestHelpers getPrivateValue:dc
//    ivarName:@"_coordinator"];
//  mom = coord.managedObjectModel;
  
}

NSObject* newObj(){
    NSObject*  obj = [[NSObject alloc] init];
    return obj;
}


-(NSObject*)objcNew{
  NSObject*  obj = [[NSObject alloc] init];
    return obj;
}


void nullOut(){
  NSObject*  obj = [[NSObject alloc] init];
  NSObject* __weak wob = obj;
  obj = nil;
}

-(void)testWeakFromCFunc{
  NSObject* __weak wob = nil;
  NSObject* sob = [self objcNew];
  wob = sob;
  sob = nil;
}

void nullRef(NSObject* __weak * wob){
  NSObject*  obj = [[NSObject alloc] init];
  *wob = obj;
}


-(void)testWeakPassedRef{
  NSObject* __weak outvar = nil;
  nullRef(&outvar);
  
}

@end
