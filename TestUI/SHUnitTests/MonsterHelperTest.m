//
//	MonsterHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/16/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import SHModels;
@import SHTestCommon;

@interface MonsterHelperTest : FrequentCase

@end

BOOL shouldUseLowerBoundChoices_mh[25];
int rIdx_mh;

uint monsterHelper_mockRandom(uint range){
	return shouldUseLowerBoundChoices_mh[rIdx_mh++] ? 0 : (range-1);
}

@implementation MonsterHelperTest

- (void)setUp {
	[super setUp];
	rIdx_mh = 0;
	shRandomUInt = &monsterHelper_mockRandom;
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}


	
-(void)testMonsterOrder{
	NSArray<NSString *> *ml = [self.monsterInfoDict getMonsterKeyList:@"NEBULA"];
	XCTAssertTrue([ml[0] isEqualToString:@"DUST_FAIRY"]);
	XCTAssertTrue([ml[1] isEqualToString:@"LOST_SAT"]);
	XCTAssertTrue([ml[2] isEqualToString:@"SENTIENT_CLOUD"]);
	XCTAssertTrue([ml[3] isEqualToString:@"CLOUD_FORTRESS"]);
	
	ml = [self.monsterInfoDict getMonsterKeyList:@"ALL"];
	XCTAssertTrue([ml[0] isEqualToString:@"M_SCOUT"]);
	XCTAssertTrue([ml[1] isEqualToString:@"SMALL_ASTEROID"]);
	XCTAssertTrue([ml[2] isEqualToString:@"SPACEMAN"]);
	XCTAssertTrue([ml[3] isEqualToString:@"MECH"]);
	XCTAssertTrue([ml[4] isEqualToString:@"SPACE_FAIRY"]);
	XCTAssertTrue([ml[5] isEqualToString:@"SPACE_SLIME"]);
	XCTAssertTrue([ml[6] isEqualToString:@"PIRATES"]);
}

-(void)testRandomMonsterKey{
	int i =0;
	shouldUseLowerBoundChoices_mh[i++] = YES;
	shouldUseLowerBoundChoices_mh[i++] = NO;
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHMonster_Medium *mm = [[SHMonster_Medium alloc]
		initWithContext:context];
	NSString *s = [mm randomMonsterKey:@"NEBULA"];
	XCTAssertTrue([s isEqualToString:@"DUST_FAIRY"]);
	s = [mm randomMonsterKey:@"NEBULA"];
	XCTAssertTrue([s isEqualToString:@"PIRATES"]);
	
}
	
-(void)testConstructRandomMonster{
	
	__block int32_t i = 0;
	
	__block NSString *fullName;
	__block int32_t lvl;
	__block int32_t maxHp;
	__block int32_t nowHp;
	
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	SHMonster_Medium *mm = [[SHMonster_Medium alloc]
		initWithContext:context];
	
	[context performBlockAndWait:^{
		i = 0;
		shouldUseLowerBoundChoices_mh[i++] = YES;
		shouldUseLowerBoundChoices_mh[i++] = YES;
		
		
		SHMonster *m = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
		fullName = m.fullName;
		lvl = m.lvl;
		maxHp = m.maxHp;
		nowHp = m.nowHp;
	}];
	
	XCTAssertTrue([fullName isEqualToString:@"Dust Fairy"]);
	XCTAssertEqual(lvl,22);
	XCTAssertEqual(maxHp,400);
	XCTAssertEqual(nowHp,400);
	
	[context performBlockAndWait:^{
		shouldUseLowerBoundChoices_mh[i++] = YES;
		shouldUseLowerBoundChoices_mh[i++] = NO;
		SHMonster *m = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
		fullName = m.fullName;
		lvl = m.lvl;
		maxHp = m.maxHp;
		nowHp = m.nowHp;
	}];
	
	XCTAssertTrue([fullName isEqualToString:@"Dust Fairy"]);
	XCTAssertEqual(lvl,42);
	XCTAssertEqual(maxHp,650);
	XCTAssertEqual(nowHp,650);
	
	[context performBlockAndWait:^{
		shouldUseLowerBoundChoices_mh[i++] = NO;
		shouldUseLowerBoundChoices_mh[i++] = YES;
		SHMonster *m = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
		fullName = m.fullName;
		lvl = m.lvl;
		maxHp = m.maxHp;
		nowHp = m.nowHp;
	}];
	
	XCTAssertTrue([fullName isEqualToString:@"Petty Space Pirates"]);
	XCTAssertEqual(lvl,22);
	XCTAssertEqual(maxHp,160);
	XCTAssertEqual(nowHp,160);
	
	[context performBlockAndWait:^{
		shouldUseLowerBoundChoices_mh[i++] = NO;
		shouldUseLowerBoundChoices_mh[i++] = NO;
		SHMonster *m = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
		fullName = m.fullName;
		lvl = m.lvl;
		maxHp = m.maxHp;
		nowHp = m.nowHp;
	}];
	
	XCTAssertTrue([fullName isEqualToString:@"Petty Space Pirates"]);
	XCTAssertEqual(lvl,42);
	XCTAssertEqual(maxHp,260);
	XCTAssertEqual(nowHp,260);
	
}


@end
