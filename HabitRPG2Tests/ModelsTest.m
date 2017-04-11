//
//  ModelsTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Daily+CoreDataClass.h"
#import "Habit+CoreDataClass.h"
#import "Todo+CoreDataClass.h"
#import "Good+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "Zone+CoreDataClass.h"
#import "Monster+CoreDataClass.h"
#import "DataInfo+CoreDataClass.h"
#import "constants.h"
#import "CoreDataStackController.h"
#import "SingletonCluster.h"

@interface ModelsTest : XCTestCase

@end

@implementation ModelsTest

    - (void)setUp {
        [super setUp];
        XCTAssertEqual([SingletonCluster getSharedInstance].EnviromentNum,ENV_UTEST);
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }
    
    -(void)testHeroProperties{
        CoreDataStackController *dc = (CoreDataStackController *)[SingletonCluster getSharedInstance].dataController;
        Hero *h = (Hero *)[dc constructEmptyEntity:HERO_ENTITY_NAME];
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
        CoreDataStackController *dc = (CoreDataStackController *)[SingletonCluster getSharedInstance].dataController;
        Monster *m = (Monster *)[dc constructEmptyEntity:MONSTER_ENTITY_NAME];
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
        CoreDataStackController *dc = (CoreDataStackController *)[SingletonCluster getSharedInstance].dataController;
        Zone *z = (Zone *)[dc constructEmptyEntity:ZONE_ENTITY_NAME];
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


@end
