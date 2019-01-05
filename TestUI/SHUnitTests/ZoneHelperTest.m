//
//  ZoneTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHModels/ModelConstants.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Zone+Helper.h>
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
    ASSERT_IS_TEST();
    randomUInt = &zoneHelper_mockRandom;
}

- (void)tearDown {
    [super tearDown];
}

-(void)testgetUnlockedZoneGroupKeys{
    NSArray<NSString *> *t = getUnlockedZoneGroupKeys(0);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_0_ZONES]);
    t = getUnlockedZoneGroupKeys(1);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    
    t = getUnlockedZoneGroupKeys(4);
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    
    t = getUnlockedZoneGroupKeys(5);
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    
    t = getUnlockedZoneGroupKeys(9);
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    
    t = getUnlockedZoneGroupKeys(10);
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    
    t = getUnlockedZoneGroupKeys(14);
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    
    t = getUnlockedZoneGroupKeys(15);
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    
    t = getUnlockedZoneGroupKeys(19);
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    
    t = getUnlockedZoneGroupKeys(20);
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);

    t = getUnlockedZoneGroupKeys(24);
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    
    t = getUnlockedZoneGroupKeys(25);
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    
    t = getUnlockedZoneGroupKeys(29);
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    
    t = getUnlockedZoneGroupKeys(30);
    XCTAssertEqual(t.count, 7);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    XCTAssertTrue([t[6] isEqualToString:LVL_30_ZONES]);
    
    t = getUnlockedZoneGroupKeys(1000);
    XCTAssertEqual(t.count, 7);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    XCTAssertTrue([t[6] isEqualToString:LVL_30_ZONES]);
}

-(void)testZoneDictionaryOrder{
    NSArray<NSString *> *zl = [[SingletonCluster getSharedInstance].zoneInfoDictionary getGroupKeyList:LVL_1_ZONES];
    XCTAssertTrue([zl[0] isEqualToString:@"NEBULA"]);
    XCTAssertTrue([zl[1] isEqualToString:@"EMPTY_SPACE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"SAFE_SPACE"]);
    XCTAssertTrue([zl[3] isEqualToString:@"GAS"]);
    
    zl = [[SingletonCluster getSharedInstance].zoneInfoDictionary getGroupKeyList:LVL_10_ZONES];
    XCTAssertTrue([zl[0] isEqualToString:@"DEFENSE"]);
    XCTAssertTrue([zl[1] isEqualToString:@"CAVE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"GARBAGE_BALL"]);
    
    zl = [[SingletonCluster getSharedInstance].zoneInfoDictionary getGroupKeyList:LVL_30_ZONES];
    XCTAssertTrue([zl[0] isEqualToString:@"WORLD_END"]);
    XCTAssertTrue([zl[1] isEqualToString:@"INFINITE"]);
    XCTAssertTrue([zl[2] isEqualToString:@"BEGINNING"]);
}

-(void)testGetRandomZoneDefinitionKey{
    int i = 0;
    rIdx_zh = 0;
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    NSString *s = getRandomZoneDefinitionKey(10);
    XCTAssertTrue([s isEqualToString:@"NEBULA"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_LOW_BOUND();
    SET_UP_BOUND();
    s = getRandomZoneDefinitionKey(10);
    XCTAssertTrue([s isEqualToString:@"GAS"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_UP_BOUND();
    s = getRandomZoneDefinitionKey(10);
    XCTAssertTrue([s isEqualToString:@"GARBAGE_BALL"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_LOW_BOUND();
    s = getRandomZoneDefinitionKey(10);
    XCTAssertTrue([s isEqualToString:@"DEFENSE"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_LOW_BOUND();
    s = getRandomZoneDefinitionKey(30);
    XCTAssertTrue([s isEqualToString:@"WORLD_END"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_UP_BOUND();
    s = getRandomZoneDefinitionKey(30);
    XCTAssertTrue([s isEqualToString:@"BEGINNING"]);
}

-(void)testGetSymbolSuffix{
    NSString *s = getSymbolSuffix(0);
    XCTAssertTrue([s isEqualToString:@""]);
    s = getSymbolSuffix(1);
    XCTAssertTrue([s isEqualToString:@"Alpha"]);
    s = getSymbolSuffix(9);
    XCTAssertTrue([s isEqualToString:@"November"]);
    s = getSymbolSuffix(100);
    XCTAssertTrue([s isEqualToString:@"Zed"]);
    s = getSymbolSuffix(101);
    XCTAssertTrue([s isEqualToString:@"Alpha Alpha"]);
    s = getSymbolSuffix(102);
    XCTAssertTrue([s isEqualToString:@"Alpha Beta"]);
    s = getSymbolSuffix(199);
    XCTAssertTrue([s isEqualToString:@"Alpha Omega"]);
    s = getSymbolSuffix(200);
    XCTAssertTrue([s isEqualToString:@"Alpha Zed"]);
    s = getSymbolSuffix(201);
    XCTAssertTrue([s isEqualToString:@"Beta Alpha"]);
    s = getSymbolSuffix(301);
    XCTAssertTrue([s isEqualToString:@"Cain Alpha"]);
    s = getSymbolSuffix(901);
    XCTAssertTrue([s isEqualToString:@"November Alpha"]);
    s = getSymbolSuffix(1001);
    XCTAssertTrue([s isEqualToString:@"Kilo Alpha"]);
    s = getSymbolSuffix(2001);
    XCTAssertTrue([s isEqualToString:@"Ludwig Alpha"]);
    s = getSymbolSuffix(3001);
    XCTAssertTrue([s isEqualToString:@"Zulu Alpha"]);
    s = getSymbolSuffix(5001);
    XCTAssertTrue([s isEqualToString:@"Flanders Alpha"]);
    s = getSymbolSuffix(8001);
    XCTAssertTrue([s isEqualToString:@"Sparta Alpha"]);
    s = getSymbolSuffix(9001);
    XCTAssertTrue([s isEqualToString:@"Superior Alpha"]);
    s = getSymbolSuffix(9051);
    XCTAssertTrue([s isEqualToString:@"Superior Berlin"]);
    s = getSymbolSuffix(9100);
    XCTAssertTrue([s isEqualToString:@"Superior Zed"]);
    s = getSymbolSuffix(9500);
    XCTAssertTrue([s isEqualToString:@"Xs Zed"]);
    s = getSymbolSuffix(9800);
    XCTAssertTrue([s isEqualToString:@"Zen Zed"]);
    s = getSymbolSuffix(9900);
    XCTAssertTrue([s isEqualToString:@"Apex Zed"]);
    s = getSymbolSuffix(9990);
    XCTAssertTrue([s isEqualToString:@"Omega Superior"]);
    s = getSymbolSuffix(9995);
    XCTAssertTrue([s isEqualToString:@"Omega Rex"]);
    s = getSymbolSuffix(9999);
    XCTAssertTrue([s isEqualToString:@"Omega Omega"]);
    s = getSymbolSuffix(10000);
    XCTAssertTrue([s isEqualToString:@"Omega Zed"]);
    s = getSymbolSuffix(10001);
    XCTAssertTrue([s isEqualToString:@"Zed Alpha"]);
    s = getSymbolSuffix(10101);
    XCTAssertTrue([s isEqualToString:@"Alpha Alpha Alpha"]);
}

-(void)testgetSymbolsList{
    NSArray<NSString *> *a = getSymbolsList();
    XCTAssertEqual(a.count, 100);
    XCTAssertTrue([a[0] isEqualToString:@"Alpha"]);
    XCTAssertTrue([a[50] isEqualToString:@"Berlin"]);
    XCTAssertTrue([a[99] isEqualToString:@"Zed"]);
}

-(void)testConstructEmptyZone{
    Zone *z = constructEmptyZone();
    XCTAssertNotNil(z);
}


-(void)testConstructZoneChoice{
    int i = 0;
    rIdx_zh = 0;
    Hero *h = (Hero *)[SHData constructEmptyEntity:Hero.entity];
    h.lvl = 14;
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    Zone *z = constructRandomZoneChoice(h,YES);
    XCTAssertTrue([z.zoneKey isEqualToString:@"NEBULA"]);
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
    z = constructRandomZoneChoice(h,YES);
    XCTAssertTrue([z.zoneKey isEqualToString:@"NEBULA"]);
    XCTAssertEqual(z.lvl, 14);
    XCTAssertTrue([z.suffix isEqualToString:@"Alpha"]);
    XCTAssertEqual(z.maxMonsters,15);
    XCTAssertEqual(z.monstersKilled, 0);
    XCTAssertTrue([z.fullName isEqualToString:@"Nebula Alpha"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    SET_UP_BOUND();
    SET_LOW_BOUND();
    z = constructRandomZoneChoice(h,NO);
    XCTAssertTrue([z.zoneKey isEqualToString:@"NEBULA"]);
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
    z = constructRandomZoneChoice(h,NO);
    XCTAssertTrue([z.zoneKey isEqualToString:@"NEBULA"]);
    XCTAssertEqual(z.lvl, 24);
    XCTAssertTrue([z.suffix isEqualToString:@"Cain"]);
    XCTAssertEqual(z.maxMonsters,15);
    XCTAssertEqual(z.monstersKilled, 0);
    XCTAssertTrue([z.fullName isEqualToString:@"Nebula Cain"]);
    
}

-(void)testConstructMultipleZoneChoices{
    Hero *h = (Hero *)[SHData constructEmptyEntity:Hero.entity];
    h.lvl = 52;
    
    int i = 0;
    rIdx_zh = 0;
    SET_LOW_BOUND();//choice count
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_LOW_BOUND(); //zone lvl
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_UP_BOUND(); //zone lvl
    
    NSArray<Zone *> *zl = constructMultipleZoneChoices(h,YES);
    XCTAssertEqual(zl.count, 3);
    XCTAssertEqual(zl[0].lvl, 52);
    XCTAssertEqual(zl[1].lvl, 42);
    XCTAssertEqual(zl[2].lvl, 62);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();//choice count
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_LOW_BOUND(); //zone lvl
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_LOW_BOUND(); //zone lvl
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_UP_BOUND(); //zone lvl
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_LOW_BOUND(); //zone lvl
    
    SET_LOW_BOUND();//zoneGroup
    SET_LOW_BOUND();//zone
    SET_UP_BOUND(); //maxMonsters
    SET_LOW_BOUND(); //zone lvl
    
    zl = constructMultipleZoneChoices(h,NO);
    XCTAssertEqual(zl.count, 5);
}

-(void)testMoveToFront{
    
    Zone *z1 = constructEmptyZone();
    z1.zoneKey = @"GAS";
    [z1 moveZoneToFront];
    [SHData insertIntoContext:z1];
    [SHData save];
    
    NSArray<NSManagedObject *> *zones = getAllZones(nil);
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"HOME"]);
    
    Zone *z2 = constructEmptyZone();
    z2.zoneKey = @"NEBULA";
    [z2 moveZoneToFront];
    [SHData insertIntoContext:z2];
    [SHData save];
    
    zones = getAllZones(nil);
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"NEBULA"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"GAS"]);
    
    //these are insync from the database?
    XCTAssertFalse(z1.isFront);
    XCTAssertTrue(z2.isFront);
    
    Zone *z1_1 = (Zone *)zones[1];
    [z1_1 moveZoneToFront];
    [SHData insertIntoContext:z1_1];
    [SHData save];
    
    zones = getAllZones(nil);
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"NEBULA"]);
    
    
}

-(void)testGetZone{
    Zone *z = constructEmptyZone();
    z.isFront = YES;
    z.zoneKey = @"NEBULA";
    Zone *z2 = constructEmptyZone();
    z2.isFront = NO;
    z2.zoneKey = @"GAS";
    [SHData insertIntoContext:z];
    [SHData insertIntoContext:z2];
    SAVE_DATA();
    Zone *z3 = getZone(YES);
    XCTAssertTrue(z3.isFront);
    XCTAssertTrue([z3.zoneKey isEqualToString:@"NEBULA"]);
    Zone *z4 = getZone(NO);
    XCTAssertTrue(!z4.isFront);
    XCTAssertTrue([z4.zoneKey isEqualToString:@"GAS"]);
    Zone *z5 = constructEmptyZone();
    z5.isFront = YES;
    z5.zoneKey = @"TEMPLE";
    [SHData insertIntoContext:z5];
    SAVE_DATA();
    XCTAssertThrows(getZone(YES));
}

@end
