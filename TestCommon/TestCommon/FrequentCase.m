//
//  FrequentCase.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import <SHModels/OnlyOneEntities.h>
#import <SHModels/Zone+CoreDataClass.h>
@import CoreData;

@interface FrequentCase ()
@property (weak,nonatomic) NSObject* weakObj;
@end

@implementation FrequentCase

-(void)setUp{
  [super setUp];
  ASSERT_IS_TEST();
  //I think we want to ensure that it uses the bundle from SHModels rather
  //the bundle for TestUI or TestCommon
  NSLog(@"context: %@",self.weakObj);
  NSBundle *testBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
  SharedGlobal.bundle = testBundle;
  CoreDataStackController* dc = [CoreDataStackController newWithBundle:testBundle storeType:NSInMemoryStoreType];
  SharedGlobal.dataController = dc;
  NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

-(void)resetDb{
  
//  [TestHelpers resetCoreData:SHData.inUseContext];
//  self.testContext = [SHData constructContext:NSMainQueueConcurrencyType];
//  self.weakContex;
//  SHData.inUseContext = self.testContext;
}



-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
dataController:(NSObject<P_CoreData>*) dataController{
  NSPredicate *filter = [NSPredicate predicateWithValue:YES];
  NSArray<NSManagedObject*>* results = [SHData getItemWithRequest:request predicate:filter sortBy:nil];
  return results;
}


-(void)tearDown{
  CoreDataStackController* __weak wdc = nil;
  SHContext* __weak context = nil;
  SHContext* __weak context2 = nil;
  NSManagedObjectModel* __weak mom = nil;
  NSPersistentStoreCoordinator* __weak store = nil;
  @autoreleasepool {
    wdc = (CoreDataStackController*)SharedGlobal.dataController;
    context = (SHContext*)[TestHelpers getPrivateValue:wdc ivarName:@"_writeContext"];
    context2 = (SHContext*)[TestHelpers getPrivateValue:wdc ivarName:@"_readContext"];
    store = context.persistentStoreCoordinator;
    NSError* error = nil;
    [store destroyPersistentStoreAtURL:wdc.storeURL withType:NSInMemoryStoreType options:nil error:&error];
    mom = context.persistentStoreCoordinator.managedObjectModel;
    SharedGlobal.dataController = nil;
    id refQue =[TestHelpers getPrivateValue:context2 ivarName:@"_referenceQueue"];
    void* rlObv = [TestHelpers getPrivateValue:refQue ivarName:@"_rlObserver"];
    [TestHelpers setPrivateVar:refQue ivarName:@"_context" newVal:nil];
//    while(CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0, 1) == kCFRunLoopRunHandledSource){
//    ;
//    }
    //[TestHelpers forceRelease:context2];
    NSDictionary* dict = NSThread.currentThread.threadDictionary;

  }
  NSLog(@"%@",context);
  NSLog(@"%@",context2);
  self.weakObj = context2;
  
  //XCTAssertNil(mom);
  //XCTAssert(nil == context);
  XCTAssertNil(wdc);
  [super tearDown];
}



@end
