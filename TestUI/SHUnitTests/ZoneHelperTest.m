//
//  ZoneTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "FrequentCase.h"
#import <SHGlobal/Constants.h>
#import <SHModels/ModelConstants.h>
#import <SHModels/Zone+Helper.h>
#import <SHCommon/CommonUtilities.h>

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
    NSArray<NSString *> *t = [Zone getUnlockedZoneGroupKeys:0];
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_0_ZONES]);
    t = [Zone getUnlockedZoneGroupKeys:1];
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:4];
    XCTAssertEqual(t.count, 1);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:5];
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:9];
    XCTAssertEqual(t.count, 2);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:10];
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:14];
    XCTAssertEqual(t.count, 3);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:15];
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:19];
    XCTAssertEqual(t.count, 4);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:20];
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);

    t = [Zone getUnlockedZoneGroupKeys:24];
    XCTAssertEqual(t.count, 5);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:25];
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:29];
    XCTAssertEqual(t.count, 6);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:30];
    XCTAssertEqual(t.count, 7);
    XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
    XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
    XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
    XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
    XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
    XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
    XCTAssertTrue([t[6] isEqualToString:LVL_30_ZONES]);
    
    t = [Zone getUnlockedZoneGroupKeys:1000];
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
    NSString *s = [Zone getRandomZoneDefinitionKey:10];
    XCTAssertTrue([s isEqualToString:@"NEBULA"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_LOW_BOUND();
    SET_UP_BOUND();
    s = [Zone getRandomZoneDefinitionKey:10];
    XCTAssertTrue([s isEqualToString:@"GAS"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_UP_BOUND();
    s = [Zone getRandomZoneDefinitionKey:10];
    XCTAssertTrue([s isEqualToString:@"GARBAGE_BALL"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_LOW_BOUND();
    s = [Zone getRandomZoneDefinitionKey:10];
    XCTAssertTrue([s isEqualToString:@"DEFENSE"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_LOW_BOUND();
    s = [Zone getRandomZoneDefinitionKey:30];
    XCTAssertTrue([s isEqualToString:@"WORLD_END"]);
    
    i = 0;
    rIdx_zh = 0;
    SET_UP_BOUND();
    SET_UP_BOUND();
    s = [Zone getRandomZoneDefinitionKey:30];
    XCTAssertTrue([s isEqualToString:@"BEGINNING"]);
}

-(void)testGetSymbolSuffix{
    NSString *s = [Zone getSymbolSuffix:0];
    XCTAssertTrue([s isEqualToString:@""]);
    s = [Zone getSymbolSuffix:1];
    XCTAssertTrue([s isEqualToString:@"Alpha"]);
    s = [Zone getSymbolSuffix:9];
    XCTAssertTrue([s isEqualToString:@"November"]);
    s = [Zone getSymbolSuffix:100];
    XCTAssertTrue([s isEqualToString:@"Zed"]);
    s = [Zone getSymbolSuffix:101];
    XCTAssertTrue([s isEqualToString:@"Alpha Alpha"]);
    s = [Zone getSymbolSuffix:102];
    XCTAssertTrue([s isEqualToString:@"Alpha Beta"]);
    s = [Zone getSymbolSuffix:199];
    XCTAssertTrue([s isEqualToString:@"Alpha Omega"]);
    s = [Zone getSymbolSuffix:200];
    XCTAssertTrue([s isEqualToString:@"Alpha Zed"]);
    s = [Zone getSymbolSuffix:201];
    XCTAssertTrue([s isEqualToString:@"Beta Alpha"]);
    s = [Zone getSymbolSuffix:301];
    XCTAssertTrue([s isEqualToString:@"Cain Alpha"]);
    s = [Zone getSymbolSuffix:901];
    XCTAssertTrue([s isEqualToString:@"November Alpha"]);
    s = [Zone getSymbolSuffix:1001];
    XCTAssertTrue([s isEqualToString:@"Kilo Alpha"]);
    s = [Zone getSymbolSuffix:2001];
    XCTAssertTrue([s isEqualToString:@"Ludwig Alpha"]);
    s = [Zone getSymbolSuffix:3001];
    XCTAssertTrue([s isEqualToString:@"Zulu Alpha"]);
    s = [Zone getSymbolSuffix:5001];
    XCTAssertTrue([s isEqualToString:@"Flanders Alpha"]);
    s = [Zone getSymbolSuffix:8001];
    XCTAssertTrue([s isEqualToString:@"Sparta Alpha"]);
    s = [Zone getSymbolSuffix:9001];
    XCTAssertTrue([s isEqualToString:@"Superior Alpha"]);
    s = [Zone getSymbolSuffix:9051];
    XCTAssertTrue([s isEqualToString:@"Superior Berlin"]);
    s = [Zone getSymbolSuffix:9100];
    XCTAssertTrue([s isEqualToString:@"Superior Zed"]);
    s = [Zone getSymbolSuffix:9500];
    XCTAssertTrue([s isEqualToString:@"Xs Zed"]);
    s = [Zone getSymbolSuffix:9800];
    XCTAssertTrue([s isEqualToString:@"Zen Zed"]);
    s = [Zone getSymbolSuffix:9900];
    XCTAssertTrue([s isEqualToString:@"Apex Zed"]);
    s = [Zone getSymbolSuffix:9990];
    XCTAssertTrue([s isEqualToString:@"Omega Superior"]);
    s = [Zone getSymbolSuffix:9995];
    XCTAssertTrue([s isEqualToString:@"Omega Rex"]);
    s = [Zone getSymbolSuffix:9999];
    XCTAssertTrue([s isEqualToString:@"Omega Omega"]);
    s = [Zone getSymbolSuffix:10000];
    XCTAssertTrue([s isEqualToString:@"Omega Zed"]);
    s = [Zone getSymbolSuffix:10001];
    XCTAssertTrue([s isEqualToString:@"Zed Alpha"]);
    s = [Zone getSymbolSuffix:10101];
    XCTAssertTrue([s isEqualToString:@"Alpha Alpha Alpha"]);
}

-(void)testgetSymbolsList{
    NSArray<NSString *> *a = [Zone getSymbolsList];
    XCTAssertEqual(a.count, 100);
    XCTAssertTrue([a[0] isEqualToString:@"Alpha"]);
    XCTAssertTrue([a[50] isEqualToString:@"Berlin"]);
    XCTAssertTrue([a[99] isEqualToString:@"Zed"]);
}

-(void)testConstructEmptyZone{
    Zone *z =[Zone constructEmptyZone];
    XCTAssertNotNil(z);
}

-(void)testConstructHomeZone{
    Zone *z = [Zone constructHomeZone];
    XCTAssertTrue([[z.synopsis substringToIndex:56] isEqualToString:@"Everyone's gotta start somewhere. For you it's the earth"]);
    //since I'm not saving HomeZone anymore, there's no point in keeping this.
    
}

-(void)testConstructZoneChoice{
    int i = 0;
    rIdx_zh = 0;
    Hero *h = (Hero *)[SHData constructEmptyEntity:Hero.entity];
    h.lvl = 14;
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    SET_LOW_BOUND();
    Zone *z = [Zone constructZoneChoice:h AndMatchHeroLvl:YES];
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
    z = [Zone constructZoneChoice:h AndMatchHeroLvl:YES];
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
    z = [Zone constructZoneChoice:h AndMatchHeroLvl:NO];
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
    z = [Zone constructZoneChoice:h AndMatchHeroLvl:NO];
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
    
    NSArray<Zone *> *zl = [Zone constructMultipleZoneChoices:h AndMatchHeroLvl:YES];
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
    
    zl = [Zone constructMultipleZoneChoices:h AndMatchHeroLvl:NO];
    XCTAssertEqual(zl.count, 5);
}

-(void)testMoveToFront{
    Zone *z0 = [Zone constructHomeZone];
    XCTAssertTrue(z0.isFront);
    [SHData insertIntoContext:z0];
    [SHData save];
    
    Zone *z1 = [Zone constructEmptyZone];
    z1.zoneKey = @"GAS";
    [Zone moveZoneToFront:z1];
    [SHData insertIntoContext:z1];
    [SHData save];
    
    NSArray<NSManagedObject *> *zones = [Zone getAllZones:nil];
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"HOME"]);
    
    Zone *z2 = [Zone constructEmptyZone];
    z2.zoneKey = @"NEBULA";
    [Zone moveZoneToFront:z2];
    [SHData insertIntoContext:z2];
    [SHData save];
    
    zones = [Zone getAllZones:nil];
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"NEBULA"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"GAS"]);
    
    //these are insync from the database?
    XCTAssertFalse(z0.isFront);
    XCTAssertFalse(z1.isFront);
    XCTAssertTrue(z2.isFront);
    
    Zone *z1_1 = (Zone *)zones[1];
    [Zone moveZoneToFront:z1_1];
    [SHData insertIntoContext:z1_1];
    [SHData save];
    
    zones = [Zone getAllZones:nil];
    XCTAssertEqual(zones.count, 2);
    XCTAssertTrue(((Zone *)zones[0]).isFront);
    XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
    XCTAssertFalse(((Zone *)zones[1]).isFront);
    XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"NEBULA"]);
    
    
}

-(void)testGetZone{
    Zone *z = [Zone constructEmptyZone];
    z.isFront = YES;
    z.zoneKey = @"NEBULA";
    Zone *z2 = [Zone constructEmptyZone];
    z2.isFront = NO;
    z2.zoneKey = @"GAS";
    [SHData insertIntoContext:z];
    [SHData insertIntoContext:z2];
    SAVE_DATA();
    Zone *z3 = [Zone getZone:YES];
    XCTAssertTrue(z3.isFront);
    XCTAssertTrue([z3.zoneKey isEqualToString:@"NEBULA"]);
    Zone *z4 = [Zone getZone:NO];
    XCTAssertTrue(!z4.isFront);
    XCTAssertTrue([z4.zoneKey isEqualToString:@"GAS"]);
    Zone *z5 = [Zone constructEmptyZone];
    z5.isFront = YES;
    z5.zoneKey = @"TEMPLE";
    [SHData insertIntoContext:z5];
    SAVE_DATA();
    XCTAssertThrows([Zone getZone:YES]);
}

@end
