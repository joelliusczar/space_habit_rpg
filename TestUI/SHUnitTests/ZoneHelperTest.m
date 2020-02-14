//
//	SectorTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/10/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//


@import SHCommon;
@import SHModels;
@import SHTestCommon;

#define SET_UP_BOUND() shouldUseLowerBoundChoices_zh[i++] = NO
#define SET_LOW_BOUND() shouldUseLowerBoundChoices_zh[i++] = YES

@interface ZoneHelperTest : FrequentCase

@end

BOOL shouldUseLowerBoundChoices_zh[25];
int rIdx_zh;

uint sectorHelper_mockRandom(uint range){
	return shouldUseLowerBoundChoices_zh[rIdx_zh++]?0:(range-1);
}

@implementation ZoneHelperTest
	
- (void)setUp {
	[super setUp];
	shRandomUInt = &sectorHelper_mockRandom;
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

-(void)testSectorDictionaryOrder{
	NSArray<NSString *> *zl = [self.sectorInfoDict getGroupKeyList:SH_LVL_1_SECTORS];
	XCTAssertTrue([zl[0] isEqualToString:@"NEBULA"]);
	XCTAssertTrue([zl[1] isEqualToString:@"EMPTY_SPACE"]);
	XCTAssertTrue([zl[2] isEqualToString:@"SAFE_SPACE"]);
	XCTAssertTrue([zl[3] isEqualToString:@"GAS"]);
	
	zl = [self.sectorInfoDict getGroupKeyList:SH_LVL_10_SECTORS];
	XCTAssertTrue([zl[0] isEqualToString:@"DEFENSE"]);
	XCTAssertTrue([zl[1] isEqualToString:@"CAVE"]);
	XCTAssertTrue([zl[2] isEqualToString:@"GARBAGE_BALL"]);
	
	zl = [self.sectorInfoDict getGroupKeyList:SH_LVL_30_SECTORS];
	XCTAssertTrue([zl[0] isEqualToString:@"WORLD_END"]);
	XCTAssertTrue([zl[1] isEqualToString:@"INFINITE"]);
	XCTAssertTrue([zl[2] isEqualToString:@"BEGINNING"]);
}

-(void)testGetRandomSectorDefinitionKey{
	int i = 0;
	rIdx_zh = 0;
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SET_LOW_BOUND();
	SET_LOW_BOUND();
	NSString *s = [sectorMed getRandomSectorDefinitionKey:10];
	XCTAssertTrue([s isEqualToString:@"NEBULA"]);
	
	i = 0;
	rIdx_zh = 0;
	SET_LOW_BOUND();
	SET_UP_BOUND();
	s = [sectorMed getRandomSectorDefinitionKey:10];
	XCTAssertTrue([s isEqualToString:@"GAS"]);
	
	i = 0;
	rIdx_zh = 0;
	SET_UP_BOUND();
	SET_UP_BOUND();
	s = [sectorMed getRandomSectorDefinitionKey:10];
	XCTAssertTrue([s isEqualToString:@"GARBAGE_BALL"]);
	
	i = 0;
	rIdx_zh = 0;
	SET_UP_BOUND();
	SET_LOW_BOUND();
	s = [sectorMed getRandomSectorDefinitionKey:10];
	XCTAssertTrue([s isEqualToString:@"DEFENSE"]);
	
	i = 0;
	rIdx_zh = 0;
	SET_UP_BOUND();
	SET_LOW_BOUND();
	s = [sectorMed getRandomSectorDefinitionKey:30];
	XCTAssertTrue([s isEqualToString:@"WORLD_END"]);
	
	i = 0;
	rIdx_zh = 0;
	SET_UP_BOUND();
	SET_UP_BOUND();
	s = [sectorMed getRandomSectorDefinitionKey:30];
	XCTAssertTrue([s isEqualToString:@"BEGINNING"]);
}

-(void)testGetSymbolSuffix{
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	NSString *s = [sectorMed getSymbolSuffix:0];
	XCTAssertTrue([s isEqualToString:@""]);
	s = [sectorMed getSymbolSuffix:1];
	XCTAssertTrue([s isEqualToString:@"Alpha"]);
	s = [sectorMed getSymbolSuffix:9];
	XCTAssertTrue([s isEqualToString:@"November"]);
	s = [sectorMed getSymbolSuffix:100];
	XCTAssertTrue([s isEqualToString:@"Zed"]);
	s = [sectorMed getSymbolSuffix:101];
	XCTAssertTrue([s isEqualToString:@"Alpha Alpha"]);
	s = [sectorMed getSymbolSuffix:102];
	XCTAssertTrue([s isEqualToString:@"Alpha Beta"]);
	s = [sectorMed getSymbolSuffix:199];
	XCTAssertTrue([s isEqualToString:@"Alpha Omega"]);
	s = [sectorMed getSymbolSuffix:200];
	XCTAssertTrue([s isEqualToString:@"Alpha Zed"]);
	s = [sectorMed getSymbolSuffix:201];
	XCTAssertTrue([s isEqualToString:@"Beta Alpha"]);
	s = [sectorMed getSymbolSuffix:301];
	XCTAssertTrue([s isEqualToString:@"Cain Alpha"]);
	s = [sectorMed getSymbolSuffix:901];
	XCTAssertTrue([s isEqualToString:@"November Alpha"]);
	s = [sectorMed getSymbolSuffix:1001];
	XCTAssertTrue([s isEqualToString:@"Kilo Alpha"]);
	s = [sectorMed getSymbolSuffix:2001];
	XCTAssertTrue([s isEqualToString:@"Ludwig Alpha"]);
	s = [sectorMed getSymbolSuffix:3001];
	XCTAssertTrue([s isEqualToString:@"Zulu Alpha"]);
	s = [sectorMed getSymbolSuffix:5001];
	XCTAssertTrue([s isEqualToString:@"Flanders Alpha"]);
	s = [sectorMed getSymbolSuffix:8001];
	XCTAssertTrue([s isEqualToString:@"Sparta Alpha"]);
	s = [sectorMed getSymbolSuffix:9001];
	XCTAssertTrue([s isEqualToString:@"Superior Alpha"]);
	s = [sectorMed getSymbolSuffix:9051];
	XCTAssertTrue([s isEqualToString:@"Superior Berlin"]);
	s = [sectorMed getSymbolSuffix:9100];
	XCTAssertTrue([s isEqualToString:@"Superior Zed"]);
	s = [sectorMed getSymbolSuffix:9500];
	XCTAssertTrue([s isEqualToString:@"Xs Zed"]);
	s = [sectorMed getSymbolSuffix:9800];
	XCTAssertTrue([s isEqualToString:@"Zen Zed"]);
	s = [sectorMed getSymbolSuffix:9900];
	XCTAssertTrue([s isEqualToString:@"Apex Zed"]);
	s = [sectorMed getSymbolSuffix:9990];
	XCTAssertTrue([s isEqualToString:@"Omega Superior"]);
	s = [sectorMed getSymbolSuffix:9995];
	XCTAssertTrue([s isEqualToString:@"Omega Rex"]);
	s = [sectorMed getSymbolSuffix:9999];
	XCTAssertTrue([s isEqualToString:@"Omega Omega"]);
	s = [sectorMed getSymbolSuffix:10000];
	XCTAssertTrue([s isEqualToString:@"Omega Zed"]);
	s = [sectorMed getSymbolSuffix:10001];
	XCTAssertTrue([s isEqualToString:@"Zed Alpha"]);
	s = [sectorMed getSymbolSuffix:10101];
	XCTAssertTrue([s isEqualToString:@"Alpha Alpha Alpha"]);
}

-(void)testGetSymbolsList{
 NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	NSArray<NSString *> *a = [sectorMed getSymbolsList];
	XCTAssertEqual(a.count, 100);
	XCTAssertTrue([a[0] isEqualToString:@"Alpha"]);
	XCTAssertTrue([a[50] isEqualToString:@"Berlin"]);
	XCTAssertTrue([a[99] isEqualToString:@"Zed"]);
}

-(void)testConstructEmptySector{
	NSManagedObjectContext *context = self.dc.mainThreadContext;
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHSector *z = [[SHSector alloc] initEmptyWithResourceUtil:self.resourceUtil];
	XCTAssertNotNil(z);
}



-(void)testConstructSectorChoice{
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	
	rIdx_zh = 0;
	[context performBlockAndWait:^{
		int i = 0;
		SHHero *h = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
		h.lvl = 14;
		SET_LOW_BOUND();
		SET_LOW_BOUND();
		SET_LOW_BOUND();
		SHSector *z = [sectorMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:YES];
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
		z = [sectorMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:YES];
		XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
		XCTAssertEqual(z.lvl, 14);
		XCTAssertTrue([z.suffix isEqualToString:@"Alpha"]);
		XCTAssertEqual(z.maxMonsters,15);
		XCTAssertEqual(z.monstersKilled, 0);
		XCTAssertTrue([z.fullName isEqualToString:@"Nebula Alpha"]);
	
		i = 0;
		rIdx_zh = 0;
		SET_LOW_BOUND(); //sectorGroup
		SET_LOW_BOUND(); //sector
		SET_LOW_BOUND(); //sector lvl
		SET_UP_BOUND(); //maxMonsters
		z = [sectorMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:NO];
		XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
		XCTAssertEqual(z.lvl, 4);
		XCTAssertTrue([z.suffix isEqualToString:@"Beta"]);
		XCTAssertEqual(z.maxMonsters,15);
		XCTAssertEqual(z.monstersKilled, 0);
		XCTAssertTrue([z.fullName isEqualToString:@"Nebula Beta"]);
	
		i = 0;
		rIdx_zh = 0;
		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_UP_BOUND(); //sector lvl

		z = [sectorMed newRandomSectorChoiceGivenHero:h ifShouldMatchLvl:NO];
		XCTAssertTrue([z.sectorKey isEqualToString:@"NEBULA"]);
		XCTAssertEqual(z.lvl, 24);
		XCTAssertTrue([z.suffix isEqualToString:@"Cain"]);
		XCTAssertEqual(z.maxMonsters,15);
		XCTAssertEqual(z.monstersKilled, 0);
		XCTAssertTrue([z.fullName isEqualToString:@"Nebula Cain"]);
	}];
		
}


-(void)testConstructMultipleSectorChoices{
	
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	
	[context performBlockAndWait:^{
		
		SHHero *h = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
		h.lvl = 52;

		int i = 0;
		rIdx_zh = 0;
		/*
		If I break these tests again, try adjusting the order of my SET_LOW_BOUND,
		SET_UP_BOUND calls below. Yes, this is a fragile test.
		*/
		SET_LOW_BOUND();//choice count
		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_LOW_BOUND(); //sector lvl
		SET_UP_BOUND(); //maxMonsters

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_UP_BOUND(); //sector lvl

		NSArray<SHSector *> *zl = [sectorMed newMultipleSectorChoicesGivenHero:h ifShouldMatchLvl:YES];
		XCTAssertEqual(zl.count, 3);
		XCTAssertEqual(zl[0].lvl, 52);
		XCTAssertEqual(zl[1].lvl, 42);
		XCTAssertEqual(zl[2].lvl, 62);

		i = 0;
		rIdx_zh = 0;
		SET_UP_BOUND();//choice count
		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_LOW_BOUND(); //sector lvl

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_LOW_BOUND(); //sector lvl

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_UP_BOUND(); //sector lvl

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_LOW_BOUND(); //sector lvl

		SET_LOW_BOUND();//sectorGroup
		SET_LOW_BOUND();//sector
		SET_UP_BOUND(); //maxMonsters
		SET_LOW_BOUND(); //sector lvl

		zl = [sectorMed newMultipleSectorChoicesGivenHero:h ifShouldMatchLvl:NO];
		XCTAssertEqual(zl.count, 5);
	}];
}

-(void)testConstructSpecificSector{
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	[context performBlockAndWait:^{
		SHSector *z = [sectorMed newSpecificSector:HOME_KEY withLvl:1 withMonsterCount:0];
		XCTAssertNotNil(z);
	}];
}

void throwsEx(){
	@throw [NSException exceptionWithName:@"x" reason:@"x" userInfo:nil];
}

-(void)testgetSector{
	XCTAssertTrue(NO);
//	NSManagedObjectContext *context = [self.dc newBackgroundContext];
//	SHSector_Medium* sectorMed = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
//	SHSector *z = [[SHSector alloc] initEmptyWithResourceUtil:self.resourceUtil];
//	NSManagedObjectContext* bgContext = [self.dc newBackgroundContext];
//	z.sectorKey = @"NEBULA";
//	SHSector *z2 = [[SHSector alloc] initEmptyWithResourceUtil:self.resourceUtil];
//	z2.sectorKey = @"GAS";
//	XCTAssertTrue([z3.sectorKey isEqualToString:@"NEBULA"]);
//	XCTAssertTrue([z4.sectorKey isEqualToString:@"GAS"]);
}


@end
