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
        [SingletonCluster getSharedInstance].EnviromentNum = ENV_UTEST;
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


@end
