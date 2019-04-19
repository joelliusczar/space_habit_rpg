//
//  ZoneTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHModels/SHModelConstants.h>
#import <SHModels/SHSector+CoreDataClass.h>
#import <SHModels/SHSector_Medium.h>
#import <SHModels/SHHeroDTO.h>
#import <SHModels/SHSectorDTO.h>

@import TestCommon;

#define SET_UP_BOUND() shouldUseLowerBoundChoices_zh[i++] = NO
#define SET_LOW_BOUND() shouldUseLowerBoundChoices_zh[i++] = YES

@interface ZoneHelperTest : FrequentCase

@end

BOOL shouldUseLowerBoundChoices_zh[25];
int rIdx_zh;

uint zoneHelper_mockRandom(uint range){
    return shouldUseLowerBoundChoices_zh[rIdx_zh++]?0:(range-1);
}

@implementation ZoneHelperTest
    
- (void)setUp {
    [super setUp];
    shRandomUInt = &zoneHelper_mockRandom;
}

- (void)tearDown {
    [super tearDown];
}

-(void)testgetUnlockedSectorGroupKeys{
  
    NSArray<NSString *> *t = getUnlockedSectorGroupKeys(0);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_0_SECTORS]);
    t = getUnlockedSectorGroupKeys(1);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(4);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(5);
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(9);
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(10);
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(14);
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(15);
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(19);
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(20);
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);

    t = getUnlockedSectorGroupKeys(24);
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(25);
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);
    XCTAssertTrue([t[5] isEqualToString:SH_LVL_25_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(29);
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);
    XCTAssertTrue([t[5] isEqualToString:SH_LVL_25_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(30);
    XCTAssertEqual(t.count, 7);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);
    XCTAssertTrue([t[5] isEqualToString:SH_LVL_25_SECTORS]);
    XCTAssertTrue([t[6] isEqualToString:SH_LVL_30_SECTORS]);
    
    t = getUnlockedSectorGroupKeys(1000);
    XCTAssertEqual(t.count, 7);
    XCTAssertTrue([t[0] isEqualToString:SH_LVL_1_SECTORS]);
    XCTAssertTrue([t[1] isEqualToString:SH_LVL_5_SECTORS]);
    XCTAssertTrue([t[2] isEqualToString:SH_LVL_10_SECTORS]);
    XCTAssertTrue([t[3] isEqualToString:SH_LVL_15_SECTORS]);
    XCTAssertTrue([t[4] isEqualToString:SH_LVL_20_SECTORS]);
    XCTAssertTrue([t[5] isEqualToString:SH_LVL_25_SECTORS]);
    XCTAssertTrue([t[6] isEqualToString:SH_LVL_30_SECTORS]);
}

-(void)testZoneDictionaryOrder{
    NSArray<NSString *> *zl = [self.zoneInfoDict getGroupKeyList:SH_LVL_1_SECTORS];
    XCTAssertTrue([zl[0] isEqualToString:@"NEBULA"]);
    XCTAssertTrue([zl[1] isEqualToString:@"EMPTY_SPACE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"SAFE_SPACE"]);
    XCTAssertTrue([zl[3] isEqualToString:@"GAS"]);
    
    zl = [self.zoneInfoDict getGroupKeyList:SH_LVL_10_SECTORS];
    XCTAssertTrue([zl[0] isEqualToString:@"DEFENSE"]);
    XCTAssertTrue([zl[1] isEqualToString:@"CAVE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"GARBAGE_BALL"]);
    
    zl = [self.zoneInfoDict getGroupKeyList:SH_LVL_30_SECTORS];
    XCTAssertTrue([zl[0] isEqualToString:@"WORLD_END"]);
    XCTAssertTrue([zl[1] isEqualToString:@"INFINITE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"BEGINNING"]);
}

-(void)testGetRandomZoneDefinitionKey{
  int i = 0;
  rIdx_zh = 0;
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  SET_LOW_BOUND();
  SET_LOW_BOUND();
  NSString *s = [zoneMed getRandomSectorDefinitionKey:10];
  XCTAssertTrue([s isEqualToString:@"NEBULA"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_LOW_BOUND();
  SET_UP_BOUND();
  s = [zoneMed getRandomSectorDefinitionKey:10];
  XCTAssertTrue([s isEqualToString:@"GAS"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_UP_BOUND();
  SET_UP_BOUND();
  s = [zoneMed getRandomSectorDefinitionKey:10];
  XCTAssertTrue([s isEqualToString:@"GARBAGE_BALL"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_UP_BOUND();
  SET_LOW_BOUND();
  s = [zoneMed getRandomSectorDefinitionKey:10];
  XCTAssertTrue([s isEqualToString:@"DEFENSE"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_UP_BOUND();
  SET_LOW_BOUND();
  s = [zoneMed getRandomSectorDefinitionKey:30];
  XCTAssertTrue([s isEqualToString:@"WORLD_END"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_UP_BOUND();
  SET_UP_BOUND();
  s = [zoneMed getRandomSectorDefinitionKey:30];
  XCTAssertTrue([s isEqualToString:@"BEGINNING"]);
}

-(void)testGetSymbolSuffix{
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  NSString *s = [zoneMed getSymbolSuffix:0];
  XCTAssertTrue([s isEqualToString:@""]);
  s = [zoneMed getSymbolSuffix:1];
  XCTAssertTrue([s isEqualToString:@"Alpha"]);
  s = [zoneMed getSymbolSuffix:9];
  XCTAssertTrue([s isEqualToString:@"November"]);
  s = [zoneMed getSymbolSuffix:100];
  XCTAssertTrue([s isEqualToString:@"Zed"]);
  s = [zoneMed getSymbolSuffix:101];
  XCTAssertTrue([s isEqualToString:@"Alpha Alpha"]);
  s = [zoneMed getSymbolSuffix:102];
  XCTAssertTrue([s isEqualToString:@"Alpha Beta"]);
  s = [zoneMed getSymbolSuffix:199];
  XCTAssertTrue([s isEqualToString:@"Alpha Omega"]);
  s = [zoneMed getSymbolSuffix:200];
  XCTAssertTrue([s isEqualToString:@"Alpha Zed"]);
  s = [zoneMed getSymbolSuffix:201];
  XCTAssertTrue([s isEqualToString:@"Beta Alpha"]);
  s = [zoneMed getSymbolSuffix:301];
  XCTAssertTrue([s isEqualToString:@"Cain Alpha"]);
  s = [zoneMed getSymbolSuffix:901];
  XCTAssertTrue([s isEqualToString:@"November Alpha"]);
  s = [zoneMed getSymbolSuffix:1001];
  XCTAssertTrue([s isEqualToString:@"Kilo Alpha"]);
  s = [zoneMed getSymbolSuffix:2001];
  XCTAssertTrue([s isEqualToString:@"Ludwig Alpha"]);
  s = [zoneMed getSymbolSuffix:3001];
  XCTAssertTrue([s isEqualToString:@"Zulu Alpha"]);
  s = [zoneMed getSymbolSuffix:5001];
  XCTAssertTrue([s isEqualToString:@"Flanders Alpha"]);
  s = [zoneMed getSymbolSuffix:8001];
  XCTAssertTrue([s isEqualToString:@"Sparta Alpha"]);
  s = [zoneMed getSymbolSuffix:9001];
  XCTAssertTrue([s isEqualToString:@"Superior Alpha"]);
  s = [zoneMed getSymbolSuffix:9051];
  XCTAssertTrue([s isEqualToString:@"Superior Berlin"]);
  s = [zoneMed getSymbolSuffix:9100];
  XCTAssertTrue([s isEqualToString:@"Superior Zed"]);
  s = [zoneMed getSymbolSuffix:9500];
  XCTAssertTrue([s isEqualToString:@"Xs Zed"]);
  s = [zoneMed getSymbolSuffix:9800];
  XCTAssertTrue([s isEqualToString:@"Zen Zed"]);
  s = [zoneMed getSymbolSuffix:9900];
  XCTAssertTrue([s isEqualToString:@"Apex Zed"]);
  s = [zoneMed getSymbolSuffix:9990];
  XCTAssertTrue([s isEqualToString:@"Omega Superior"]);
  s = [zoneMed getSymbolSuffix:9995];
  XCTAssertTrue([s isEqualToString:@"Omega Rex"]);
  s = [zoneMed getSymbolSuffix:9999];
  XCTAssertTrue([s isEqualToString:@"Omega Omega"]);
  s = [zoneMed getSymbolSuffix:10000];
  XCTAssertTrue([s isEqualToString:@"Omega Zed"]);
  s = [zoneMed getSymbolSuffix:10001];
  XCTAssertTrue([s isEqualToString:@"Zed Alpha"]);
  s = [zoneMed getSymbolSuffix:10101];
  XCTAssertTrue([s isEqualToString:@"Alpha Alpha Alpha"]);
}

-(void)testGetSymbolsList{
 NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  NSArray<NSString *> *a = [zoneMed getSymbolsList];
  XCTAssertEqual(a.count, 100);
  XCTAssertTrue([a[0] isEqualToString:@"Alpha"]);
  XCTAssertTrue([a[50] isEqualToString:@"Berlin"]);
  XCTAssertTrue([a[99] isEqualToString:@"Zed"]);
}

-(void)testConstructEmptyZone{
  NSManagedObjectContext *context = self.dc.mainThreadContext;
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  SHSector *z = [zoneMed newEmptySector];
  XCTAssertNotNil(z);
}



-(void)testConstructZoneChoice{
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  int i = 0;
  rIdx_zh = 0;
  SHHeroDTO *h = [SHHeroDTO new];
  h.lvl = 14;
  SET_LOW_BOUND();
  SET_LOW_BOUND();
  SET_LOW_BOUND();
  SHSectorDTO *z = [zoneMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:YES];
  XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
  XCTAssertEqual(z.lvl, 14);
  XCTAssertTrue([z.suffix isEqualToString:@""]);
  XCTAssertEqual(z.maxMonsters,5);
  XCTAssertEqual(z.monstersKilled, 0);
  XCTAssertTrue([z.fullName isEqualToString:@"Nebula"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_LOW_BOUND();
  SET_LOW_BOUND();
  SET_UP_BOUND();
  z = [zoneMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:YES];
  XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
  XCTAssertEqual(z.lvl, 14);
  XCTAssertTrue([z.suffix isEqualToString:@"Alpha"]);
  XCTAssertEqual(z.maxMonsters,15);
  XCTAssertEqual(z.monstersKilled, 0);
  XCTAssertTrue([z.fullName isEqualToString:@"Nebula Alpha"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_LOW_BOUND(); //zoneGroup
  SET_LOW_BOUND(); //zone
  SET_LOW_BOUND(); //zone lvl
  SET_UP_BOUND(); //maxMonsters
  z = [zoneMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:NO];
  XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
  XCTAssertEqual(z.lvl, 4);
  XCTAssertTrue([z.suffix isEqualToString:@"Beta"]);
  XCTAssertEqual(z.maxMonsters,15);
  XCTAssertEqual(z.monstersKilled, 0);
  XCTAssertTrue([z.fullName isEqualToString:@"Nebula Beta"]);
  
  i = 0;
  rIdx_zh = 0;
  SET_LOW_BOUND();//zoneGroup
  SET_LOW_BOUND();//zone
  SET_UP_BOUND(); //maxMonsters
  SET_UP_BOUND(); //zone lvl
  z = [zoneMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:NO];
  XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
  XCTAssertEqual(z.lvl, 24);
  XCTAssertTrue([z.suffix isEqualToString:@"Cain"]);
  XCTAssertEqual(z.maxMonsters,15);
  XCTAssertEqual(z.monstersKilled, 0);
  XCTAssertTrue([z.fullName isEqualToString:@"Nebula Cain"]);
    
}


#warning put back
//-(void)testConstructMultipleZoneChoices{
//    Hero *h = (Hero *)[self.dc constructEmptyEntity:Hero.entity];
//    h.lvl = 52;
//
//    int i = 0;
//    rIdx_zh = 0;
//    /*
//    If I break these tests again, try adjusting the order of my SET_LOW_BOUND,
//    SET_UP_BOUND calls below. Yes, this is a fragile test.
//    */
//    SET_LOW_BOUND();//choice count
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_LOW_BOUND(); //zone lvl
//    SET_UP_BOUND(); //maxMonsters
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_UP_BOUND(); //zone lvl
//
//    NSArray<Zone *> *zl = constructMultipleZoneChoices(h,YES);
//    XCTAssertEqual(zl.count, 3);
//    XCTAssertEqual(zl[0].lvl, 52);
//    XCTAssertEqual(zl[1].lvl, 42);
//    XCTAssertEqual(zl[2].lvl, 62);
//
//    i = 0;
//    rIdx_zh = 0;
//    SET_UP_BOUND();//choice count
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_LOW_BOUND(); //zone lvl
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_LOW_BOUND(); //zone lvl
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_UP_BOUND(); //zone lvl
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_LOW_BOUND(); //zone lvl
//
//    SET_LOW_BOUND();//zoneGroup
//    SET_LOW_BOUND();//zone
//    SET_UP_BOUND(); //maxMonsters
//    SET_LOW_BOUND(); //zone lvl
//
//    zl = constructMultipleZoneChoices(h,NO);
//    XCTAssertEqual(zl.count, 5);
//}

-(void)testConstructSpecificZone{
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  SHSectorDTO *z = [zoneMed newSpecificSector:HOME_KEY withLvl:1 withMonsterCount:0];
  XCTAssertNotNil(z);
}

void throwsEx(){
  @throw [NSException exceptionWithName:@"x" reason:@"x" userInfo:nil];
}

-(void)testgetSector{
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  __block SHSector *z = [zoneMed newEmptySector];
  NSManagedObjectContext* bgContext = [self.dc newBackgroundContext];
  z.isFront = YES;
  z.sectorKey = @"NEBULA";
  __block SHSector *z2 = [zoneMed newEmptySector];
  z2.isFront = NO;
  z2.sectorKey = @"GAS";
  [bgContext performBlockAndWait:^{
    [bgContext insertObject:z];
    [bgContext insertObject:z2];
    NSError *error = nil;
    [bgContext save:&error];
  }];
  SHSector *z3 = [zoneMed getSector:YES];
  XCTAssertTrue(z3.isFront);
  XCTAssertTrue([z3.sectorKey isEqualToString:@"NEBULA"]);
  SHSector *z4 = [zoneMed getSector:NO];
  XCTAssertTrue(!z4.isFront);
  XCTAssertTrue([z4.sectorKey isEqualToString:@"GAS"]);
  __block SHSector *z5 = [zoneMed newEmptySector];
  z5.isFront = YES;
  z5.sectorKey = @"TEMPLE";
  [bgContext performBlockAndWait:^{
    [bgContext insertObject:z5];
    NSError *error = nil;
    [bgContext save:&error];
  }];
  XCTAssertThrows([zoneMed getSector:YES]);
}


-(void)testMoveToFront{
  NSManagedObjectContext *context = [self.dc newBackgroundContext];
  SHSector_Medium* zoneMed = [SHSector_Medium newWithContext:context
    withResourceUtil:self.resourceUtil
    withInfoDict:self.zoneInfoDict];
  __block SHSectorDTO *z0 = [zoneMed newSpecificSector:HOME_KEY withLvl:1 withMonsterCount:0];;
  NSManagedObjectContext* bgContext = [self.dc newBackgroundContext];
  
  [bgContext performBlockAndWait:^{
    SHSector *zCd = (SHSector*)[bgContext newEntity:SHSector.entity];
    [zoneMed moveSectorToFront:zCd];
    XCTAssertTrue(zCd.isFront);
    NSError *error = nil;
    [bgContext save:&error];
  }];

  __block SHSector *z1 = [zoneMed newEmptySector];
  z1.sectorKey = @"GAS";
  
  [bgContext performBlockAndWait:^{
    [bgContext insertObject:z1];
    [zoneMed moveSectorToFront:z1];
    NSError *error = nil;
    [bgContext save:&error];
  }];
  
  NSArray<NSManagedObject *> *zones = [zoneMed getAllSectors:nil];
  XCTAssertEqual(zones.count, 2);
  XCTAssertTrue(((SHSector *)zones[0]).isFront);
  XCTAssertTrue([((SHSector *)zones[0]).sectorKey isEqualToString:@"GAS"]);
  XCTAssertFalse(((SHSector *)zones[1]).isFront);
  XCTAssertTrue([((SHSector *)zones[1]).sectorKey isEqualToString:@"HOME"]);
  
  __block SHSector *z2 = [zoneMed newEmptySector];
  z2.sectorKey = @"NEBULA";
  
  [bgContext performBlockAndWait:^{
    [bgContext insertObject:z2];
    [zoneMed moveSectorToFront:z2];
    NSError *error = nil;
    [bgContext save:&error];
  }];
  [bgContext performBlockAndWait:^{
    NSArray<NSManagedObject *> *zones = [zoneMed getAllSectors:nil];
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((SHSector *)zones[0]).isFront);
    XCTAssertTrue([((SHSector *)zones[0]).sectorKey isEqualToString:@"NEBULA"]);
    XCTAssertFalse(((SHSector *)zones[1]).isFront);
    XCTAssertTrue([((SHSector *)zones[1]).sectorKey isEqualToString:@"GAS"]);
    
    //these are insync from the database?
    XCTAssertFalse(z1.isFront);
    XCTAssertTrue(z2.isFront);
    
    SHSector *z1_1 = (SHSector *)zones[1];
    [zoneMed moveSectorToFront:z1_1];
    [bgContext insertObject:z1_1]; //#warning
    NSError *error = nil;
    [bgContext save:&error];
    
    zones = [zoneMed getAllSectors:nil];
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((SHSector *)zones[0]).isFront);
    XCTAssertTrue([((SHSector *)zones[0]).sectorKey isEqualToString:@"GAS"]);
    XCTAssertFalse(((SHSector *)zones[1]).isFront);
    XCTAssertTrue([((SHSector *)zones[1]).sectorKey isEqualToString:@"NEBULA"]);
  }];
  
}




@end
