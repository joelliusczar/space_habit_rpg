//
//	ModelsTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHModels;


@import SHTestCommon;

@interface ModelsTest : FrequentCase

@end

@implementation ModelsTest

- (void)setUp {
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
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
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	[context performBlockAndWait:^{
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
		
	}];
}


-(void)testSectorProperties{
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	[context performBlockAndWait:^{
		SHSector *z = [[SHSector alloc] initEmptyWithResourceUtil:self.resourceUtil];
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
		
	}];
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
