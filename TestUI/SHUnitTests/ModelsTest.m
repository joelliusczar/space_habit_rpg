//
//  ModelsTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHModels/Habit+CoreDataClass.h>
#import <SHModels/Todo+CoreDataClass.h>
#import <SHModels/Good+CoreDataClass.h>
#import <SHModels/Hero+CoreDataClass.h>
#import <SHModels/Settings+CoreDataClass.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Monster+CoreDataClass.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/DataInfo+CoreDataClass.h>
#import <SHModels/ZoneTransaction+CoreDataClass.h>
#import <SHGlobal/Constants.h>
#import <SHData/SHCoreData.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/SingletonCluster+Entity.h>
#import <SHModels/Zone_Medium.h>
@import TestCommon;

@interface ModelsTest : FrequentCase

@end

@implementation ModelsTest

- (void)setUp {
  [super setUp];
  XCTAssertEqual(SharedGlobal.EnviromentNum,ENV_UTEST);
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
  [super tearDown];
}

-(void)testHeroProperties{
  NSObject<P_CoreData> *dc = SharedGlobal.dataController;
  NSManagedObjectContext *context = dc.mainThreadContext;
  Hero *h = (Hero *)[context newEntity:Hero.entity];
  h.gold = 3.14;
  h.lvl = 15;
  h.maxHp = 56;
  h.nowHp = 32;
  h.nowXp = 22;
  h.shipName = @"bean";
  XCTAssertEqualWithAccuracy(h.gold, 3.14, .011);
  XCTAssertEqual(h.lvl, 15);
  XCTAssertEqual(h.maxHp, 56);
  XCTAssertEqual(h.nowHp, 32);
  XCTAssertEqual(h.nowXp, 22);
  XCTAssertTrue([h.shipName isEqualToString:@"bean"]);
}

-(void)testMonsterProperties{
  NSObject<P_CoreData> *dc = SharedGlobal.dataController;
  NSManagedObjectContext *context = dc.mainThreadContext;
  Monster *m = (Monster *)[context newEntity:Monster.entity];
  m.lvl = 13;
  m.monsterKey = @"DUST_FAIRY";
  m.nowHp = 123;
  XCTAssertEqual(m.lvl, 13);
  XCTAssertEqual(m.maxHp,287);
  XCTAssertEqual(m.nowHp, 123);
  XCTAssertEqual(m.xp, 1);
  XCTAssertTrue([m.fullName isEqualToString:@"Dust Fairy"]);
  XCTAssertEqual(m.defense, 0);
  XCTAssertEqualWithAccuracy(m.treasureDropRate, .1, .011);
  XCTAssertEqual(m.encounterWeight, 25);
  XCTAssertEqual(m.attack, 17);
  XCTAssertTrue([[m.synopsis substringToIndex:37] isEqualToString:@"Dust Fairies are fiercely territorial"]);
}

-(void)testZoneProperties{
  NSObject<P_CoreData> *dc = SharedGlobal.dataController;
  NSManagedObjectContext *context = dc.mainThreadContext;
  Zone *z = (Zone *)[context newEntity:Zone.entity];
  z.lvl = 5;
  z.zoneKey = @"SAFE_SPACE";
  z.isFront = YES;
  z.maxMonsters = 17;
  z.monstersKilled = 8;
  z.suffix = @"Test";
  z.uniqueId = 13;
  XCTAssertEqual(z.lvl, 5);
  XCTAssertEqual(z.isFront, YES);
  XCTAssertEqual(z.maxMonsters, 17);
  XCTAssertEqual(z.monstersKilled, 8);
  XCTAssertEqual(z.uniqueId, 13);
  NSString *pStr = z.fullName;
  XCTAssertTrue([pStr isEqualToString:@"Safe Space Test"]);
  XCTAssertTrue([[z.synopsis substringToIndex:53] isEqualToString:@"Here in safe space, they enforce even the small rules"]);
}

-(void)testRemoveEntitRefBeforeSaving{
  NSObject<P_CoreData> *dc = SharedGlobal.dataController;
  NSManagedObjectContext *bgContext = [dc newBackgroundContext];
  [bgContext performBlockAndWait:^{
    ZoneTransaction *zt = (ZoneTransaction *)[bgContext newEntity:ZoneTransaction.entity];
    zt.misc = @"Just random shit!";
    zt = nil;
    NSError* error = nil;
    [bgContext save:&error];
  }];
  
  NSFetchRequest<ZoneTransaction*>* request = [ZoneTransaction fetchRequest];
  
  NSArray<NSManagedObject*>* results = [self fetchAnything:request context:dc.mainThreadContext];
  NSAssert(results.count == 1,@"result was not one");
  NSString *misc = ((ZoneTransaction*)results[0]).misc;
  NSAssert([misc isEqualToString:@"Just random shit!"],@"Strings not equal");
}

-(void)testDoubleInsert{
  Zone_Medium* zoneMed = [Zone_Medium newWithDataController:SHData
    withResourceUtil:SharedGlobal.resourceUtility withInfoDict:SharedGlobal.zoneInfoDictionary];
  NSManagedObjectContext* bgContext = [SHData newBackgroundContext];
  [bgContext performBlockAndWait:^{
    Zone *z = [zoneMed constructSpecificZone2:@"SAFE_SPACE" withLvl:16];
    [bgContext insertObject:z];
    [bgContext insertObject:z];
    NSError* error = nil;
    [bgContext save:&error];
  }];
  //I think this next part is useless
  NSManagedObjectContext* bgContext2 = [SHData newBackgroundContext];
  NSFetchRequest<Zone *> *request = [Zone fetchRequest];
  [bgContext2 performBlockAndWait:^{
    NSArray<NSManagedObject*>* results = [self fetchAnything:request context:bgContext2];
    NSAssert(results.count == 1,@"result was not one");
    Zone *z_ret = (Zone *)results[0];
    [bgContext2 insertObject:z_ret];
    NSError *error = nil;
    [bgContext2 save:&error];
    NSArray<NSManagedObject*>* results2 = [self fetchAnything:request context:bgContext2];
    NSAssert(results2.count == 1,@"result was not one");
    
  }];
  //this last part is to verify that it's not just returning only one
  //regardless of what is in stored
  [bgContext performBlockAndWait:^{
    
    Zone *z3 = [zoneMed constructSpecificZone2:@"SAFE_SPACE" withLvl:16];
    [bgContext insertObject:z3];
    NSError *error = nil;
    [bgContext save:&error];
  }];
  
  NSManagedObjectContext* bgContext3 = [SHData newBackgroundContext];
  [bgContext3 performBlockAndWait:^{
    
    NSArray<NSManagedObject*>* results3 = [self fetchAnything:request context:bgContext3];
    NSAssert(results3.count == 2,@"result was not two");
  }];

}

@end
