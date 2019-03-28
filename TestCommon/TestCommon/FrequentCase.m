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
#import <SHData/NSManagedObjectContext+Helper.h>
@import CoreData;

@interface FrequentCase ()
@property (weak,nonatomic) NSObject* weakObj;
@property (strong,nonatomic) NSObject* strongObj;
@property (strong,nonatomic) NSPersistentStoreCoordinator *coordinator;
@end

@implementation FrequentCase

-(void)setUp{
  [super setUp];
  ASSERT_IS_TEST();
  //I think we want to ensure that it uses the bundle from SHModels rather
  //the bundle for TestUI or TestCommon
  NSBundle *testBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
  SharedGlobal.bundle = testBundle;
  NSPersistentStoreCoordinator *coordinator = self.coordinator;
  SHCoreData *dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
    options.storeType = NSInMemoryStoreType;
    options.appBundle = testBundle;
    if(coordinator){
      options.coordinator = coordinator;
    }
  }];
  SharedGlobal.dataController = dc;
  //DumbCoreDataController* dc = [DumbCoreDataController newWithBundle:testBundle storeType:NSInMemoryStoreType];
  NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

-(void)resetDb{
  
//  [TestHelpers resetCoreData:SHData.inUseContext];
//  self.testContext = [SHData constructContext:NSMainQueueConcurrencyType];
//  self.weakContex;
//  SHData.inUseContext = self.testContext;
}



-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context{
  request.predicate = [NSPredicate predicateWithValue:YES];
  
  NSArray<NSManagedObject*>* results = [context getItemsWithRequest:request];
  return results;
}

-(void)tearDown{
  [super tearDown];
}



@end
