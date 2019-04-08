//
//  FrequentCase.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import "SHCoreData+CleanUp.h"
#import <SHModels/OnlyOneEntities.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHData/NSManagedObjectContext+Helper.h>

@import CoreData;

@interface FrequentCase ()
@property (weak,nonatomic) NSObject* weakObj;
@property (strong,nonatomic) NSObject* strongObj;
@property (strong,nonatomic) SHCoreData* dc;
@end

@implementation FrequentCase

-(void)setUp{
  [super setUp];
  ASSERT_IS_TEST();
  //I think we want to ensure that it uses the bundle from SHModels rather
  //the bundle for TestUI or TestCommon
  NSBundle *testBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
  SharedGlobal.bundle = testBundle;
  SharedGlobal.constructorBlock = ^(SHCoreDataOptions *options){
    options.storeType = NSInMemoryStoreType;
    options.appBundle = testBundle;
  };
  self.dc = (SHCoreData*)SHData;
  NSTimeZone.defaultTimeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
}

-(void)resetDb{
  [self.dc resetCoreData];
  
}



-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context{
  request.predicate = [NSPredicate predicateWithValue:YES];
  
  NSArray<NSManagedObject*>* results = [context getItemsWithRequest:request];
  return results;
}

-(void)tearDown{
//  NSManagedObjectContext *mainThreadContext = SHData.mainThreadContext;
//  SharedGlobal.dataController = nil;
//  void *releasable = (__bridge void*)mainThreadContext;
//  CFRelease(releasable);
  [self resetDb];
  [super tearDown];
}



@end
