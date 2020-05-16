//
//  SHModelTests.m
//  SHModelsTests
//
//  Created by Joel Pridgen on 5/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHTestResourceUtil.h"
#import "SHFrequentCase.h"
@import SHModels;

@interface SHModelTests : SHFrequentCase
@end

@implementation SHModelTests

static BOOL shouldUseLowerBound =YES;
static uint (*ogRandFn)(uint);

uint mockRandom(uint bound){
	return shouldUseLowerBound?0:(bound-1);
}

-(void)setUp {
	[super setUp];
	ogRandFn = shRandomUInt;
	shRandomUInt = &mockRandom;
}

-(void)tearDown {
	[super tearDown];
}

-(void)testRandomUintF{
  uint bound = 25;
  uint result = ogRandFn(bound);
  XCTAssertTrue(result >= 0 && result <= 25);
}



-(void)testCalculateLvl{
	uint offset = 10;
	
	uint lvl = 0;
	shouldUseLowerBound = YES;
	NSInteger result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 11);
	lvl = 1;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 11);
	lvl = 2;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 12);
	lvl = 5;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 15);
	lvl = 9;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 19);
	lvl = 10;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 20);
	lvl = 11;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 1);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 21);
	lvl = 12;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 2);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 22);
	lvl = 15;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 5);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 25);
	lvl = 55;
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 45);
	shouldUseLowerBound = !shouldUseLowerBound;
	result = shCalculateLvl(lvl,offset);
	XCTAssertEqual(result, 65);
	
}


-(void)testHeroProperties{
	SHHero *h = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
	h.gold = 3.14;
	h.lvl = 15;
	h.maxHp = 56;
	h.nowHp = 32;
	h.nowXp = 22;
//	h.shipName = @"bean";
	XCTAssertEqual(h.gold, 3);
	XCTAssertEqual(h.lvl, 15);
	XCTAssertEqual(h.maxHp, 56);
	XCTAssertEqual(h.nowHp, 32);
	XCTAssertEqual(h.nowXp, 22);
	//XCTAssertTrue([h.shipName isEqualToString:@"bean"]);
}


-(void)testMonsterProperties{
	SHMonster *m = [[SHMonster alloc] initEmptyWithResourceUtil:self.resourceUtil];
	m.lvl = 13;
	m.monsterKey = @"DUST_FAIRY";
	m.nowHp = 123;
	XCTAssertEqual(m.lvl, 13);
	XCTAssertEqual(m.maxHp,287);
	XCTAssertEqual(m.nowHp, 123);
	XCTAssertEqual(m.xp, 2);
	XCTAssertTrue([m.fullName isEqualToString:@"Dust Fairy"]);
	XCTAssertEqual(m.defense, 0);
	XCTAssertEqualWithAccuracy(m.treasureDropRate, .1, .011);
	XCTAssertEqual(m.encounterWeight, 25);
	XCTAssertEqual(m.attack, 17);
	XCTAssertTrue([[m.synopsis substringToIndex:37] isEqualToString:@"Dust Fairies are fiercely territorial"]);
}


-(void)testSectorProperties{
	SHSector *z = [[SHSector alloc] initWithResourceUtil:self.resourceUtil];
	z.lvl = 5;
	z.sectorKey = @"SAFE_SPACE";
	z.maxMonsters = 17;
	z.monstersKilled = 8;
	z.suffix = @"Test";
	XCTAssertEqual(z.lvl, 5);
	XCTAssertEqual(z.maxMonsters, 17);
	XCTAssertEqual(z.monstersKilled, 8);
	NSString *pStr = z.fullName;
	XCTAssertTrue([pStr isEqualToString:@"Safe Space Test"]);
	XCTAssertTrue([[z.synopsis substringToIndex:53] isEqualToString:@"Here in safe space, they enforce even the small rules"]);
}

-(void)testRemoveEntitRefBeforeSaving{
	NSObject<SHDataProviderProtocol> *dc = self.dc;
	NSManagedObjectContext *bgContext = [dc newBackgroundContext];
	[bgContext performBlockAndWait:^{
		SHTransaction *zt = (SHTransaction *)[bgContext newEntity:SHTransaction.entity];
		zt.misc = @"Just random shit!";
		zt = nil;
		NSError* error = nil;
		[bgContext save:&error];
	}];
	
	NSFetchRequest<SHTransaction*>* request = [SHTransaction fetchRequest];
	
	NSArray<NSManagedObject*>* results = [self fetchAnything:request context:dc.mainThreadContext];
	NSAssert(results.count == 1,@"result was not one");
	NSString *misc = ((SHTransaction*)results[0]).misc;
	NSAssert([misc isEqualToString:@"Just random shit!"],@"Strings not equal");
}

@end
