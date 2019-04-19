//
//  FrequentCase.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import "SHCoreData+CleanUp.h"
#import <SHModels/SHSector+CoreDataClass.h>
#import <SHData/NSManagedObjectContext+Helper.h>

@import CoreData;

@interface FrequentCase ()
@property (weak,nonatomic) NSObject* weakObj;
@property (strong,nonatomic) NSObject* strongObj;
@property (strong,nonatomic) NSBundle *testBundle;
@end

@implementation FrequentCase


SHCoreData* getDataControllerSingleton(){
  static SHCoreData *dc = nil;
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken,^{
    dc = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
      options.storeType = NSInMemoryStoreType;
      options.appBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
    }];
  });
  return dc;
}

-(void)setUp{
  [super setUp];
  self.resourceUtil = [[SHResourceUtility alloc] init];
  self.zoneInfoDict = [SHSectorInfoDictionary newWithResourceUtil:self.resourceUtil];
  self.monsterInfoDict = [SHMonsterInfoDictionary newWithResourceUtil:self.resourceUtil];
  //I think we want to ensure that it uses the bundle from SHModels rather
  //the bundle for TestUI or TestCommon
  self.dc = getDataControllerSingleton();
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
