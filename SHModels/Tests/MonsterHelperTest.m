//
//	MonsterHelperTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/16/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHFrequentCase.h"
@import SHModels;

@interface MonsterHelperTest : SHFrequentCase

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
	
	ml = [[self.monsterInfoDict getMonsterKeyList:@"ALL"] sortedArrayUsingComparator:^(id A, id B){
		NSString *AStr = (NSString*)A;
		NSString *BStr = (NSString*)B;
		return [AStr compare:BStr];
	}];
	XCTAssertTrue([ml[0] isEqualToString:@"MECH"]);
	XCTAssertTrue([ml[1] isEqualToString:@"M_SCOUT"]);
	XCTAssertTrue([ml[2] isEqualToString:@"PIRATES"]);
	XCTAssertTrue([ml[3] isEqualToString:@"SMALL_ASTEROID"]);
	XCTAssertTrue([ml[4] isEqualToString:@"SPACEMAN"]);
	XCTAssertTrue([ml[5] isEqualToString:@"SPACE_FAIRY"]);
	XCTAssertTrue([ml[6] isEqualToString:@"SPACE_SLIME"]);
}

-(void)testRandomMonsterKey{
	int i =0;
	shouldUseLowerBoundChoices_mh[i++] = YES;
	shouldUseLowerBoundChoices_mh[i++] = NO;
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
	NSString *s = [mm randomMonsterKey:@"NEBULA"];
	XCTAssertTrue([s isEqualToString:@"DUST_FAIRY"]);
	s = [mm randomMonsterKey:@"NEBULA"];
	XCTAssertTrue([s isEqualToString:@"PIRATES"]);
	
}
	
-(void)testConstructRandomMonster{
	
	int32_t i = 0;
	
	NSString *fullName;
	NSInteger lvl;
	NSInteger maxHp;
	NSInteger nowHp;
	
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
	
	i = 0;
	shouldUseLowerBoundChoices_mh[i++] = YES;
	shouldUseLowerBoundChoices_mh[i++] = YES;
	
	
	SHMonster *m = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
	fullName = m.fullName;
	lvl = m.lvl;
	maxHp = m.maxHp;
	nowHp = m.nowHp;
	
	XCTAssertTrue([fullName isEqualToString:@"Dust Fairy"]);
	XCTAssertEqual(lvl,22);
	XCTAssertEqual(maxHp,400);
	XCTAssertEqual(nowHp,400);
	
	shouldUseLowerBoundChoices_mh[i++] = YES;
	shouldUseLowerBoundChoices_mh[i++] = NO;
	SHMonster *m2 = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
	fullName = m2.fullName;
	lvl = m2.lvl;
	maxHp = m2.maxHp;
	nowHp = m2.nowHp;
	
	XCTAssertTrue([fullName isEqualToString:@"Dust Fairy"]);
	XCTAssertEqual(lvl,42);
	XCTAssertEqual(maxHp,650);
	XCTAssertEqual(nowHp,650);
	
	shouldUseLowerBoundChoices_mh[i++] = NO;
	shouldUseLowerBoundChoices_mh[i++] = YES;
	SHMonster *m3 = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
	fullName = m3.fullName;
	lvl = m3.lvl;
	maxHp = m3.maxHp;
	nowHp = m3.nowHp;
	
	XCTAssertTrue([fullName isEqualToString:@"Petty Space Pirates"]);
	XCTAssertEqual(lvl,22);
	XCTAssertEqual(maxHp,160);
	XCTAssertEqual(nowHp,160);
	
	shouldUseLowerBoundChoices_mh[i++] = NO;
	shouldUseLowerBoundChoices_mh[i++] = NO;
	SHMonster *m4 = [mm newRandomMonster:@"NEBULA" sectorLvl:32];
	fullName = m4.fullName;
	lvl = m4.lvl;
	maxHp = m4.maxHp;
	nowHp = m4.nowHp;
	
	XCTAssertTrue([fullName isEqualToString:@"Petty Space Pirates"]);
	XCTAssertEqual(lvl,42);
	XCTAssertEqual(maxHp,260);
	XCTAssertEqual(nowHp,260);
	
}


@end
