//
//	ModelsTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 4/7/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHModels;
@import SHGlobal;

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
	NSObject<SHDataProviderProtocol> *dc = self.dc;
	NSManagedObjectContext *context = dc.mainThreadContext;
	SHHero *h = (SHHero *)[context newEntity:SHHero.entity];
	h.gold = 3.14;
	h.lvl = 15;
	h.maxHp = 56;
	h.nowHp = 32;
	h.nowXp = 22;
	h.shipName = @"bean";
	XCTAssertEqual(h.gold, 3);
	XCTAssertEqual(h.lvl, 15);
	XCTAssertEqual(h.maxHp, 56);
	XCTAssertEqual(h.nowHp, 32);
	XCTAssertEqual(h.nowXp, 22);
	XCTAssertTrue([h.shipName isEqualToString:@"bean"]);
}


-(void)testMonsterProperties{
	NSManagedObjectContext *context = [self.dc newBackgroundContext];
	[context performBlockAndWait:^{
		SHMonster *m = (SHMonster*)[context newEntity:SHMonster.entity];
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
		SHSector *z = (SHSector*)[context newEntity:SHSector.entity];
		z.lvl = 5;
		z.sectorKey = @"SAFE_SPACE";
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

-(void)testDoubleInsert{
	NSManagedObjectContext* bgContext = [self.dc newBackgroundContext];
	SHSector_Medium* sectorMed = [SHSector_Medium
		newWithContext:bgContext
		withResourceUtil:self.resourceUtil];
	
	[bgContext performBlockAndWait:^{
		SHSector *z = [sectorMed newSpecificSector2:@"SAFE_SPACE" withLvl:16];
		[bgContext insertObject:z];
		[bgContext insertObject:z];
		NSError* error = nil;
		[bgContext save:&error];
	}];
	//I think this next part is useless
	NSManagedObjectContext* bgContext2 = [self.dc newBackgroundContext];
	NSFetchRequest<SHSector *> *request = [SHSector fetchRequest];
	[bgContext2 performBlockAndWait:^{
		NSArray<NSManagedObject*>* results = [self fetchAnything:request context:bgContext2];
		NSAssert(results.count == 1,@"result was not one");
		SHSector *z_ret = (SHSector *)results[0];
		[bgContext2 insertObject:z_ret];
		NSError *error = nil;
		[bgContext2 save:&error];
		NSArray<NSManagedObject*>* results2 = [self fetchAnything:request context:bgContext2];
		NSAssert(results2.count == 1,@"result was not one");
		
	}];
	//this last part is to verify that it's not just returning only one
	//regardless of what is in stored
	[bgContext performBlockAndWait:^{
		SHSector *z3 = [sectorMed newSpecificSector2:@"SAFE_SPACE" withLvl:16];
		[bgContext insertObject:z3];
		NSError *error = nil;
		[bgContext save:&error];
	}];
	
	NSManagedObjectContext* bgContext3 = [self.dc newBackgroundContext];
	[bgContext3 performBlockAndWait:^{
		
		NSArray<NSManagedObject*>* results3 = [self fetchAnything:request context:bgContext3];
		NSAssert(results3.count == 2,@"result was not two");
	}];

}

@end
