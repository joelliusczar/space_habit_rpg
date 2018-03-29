//
//  MonsterHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHModels/Monster+Helper.h>
@import TestCommon;

@interface MonsterHelperTest : FrequentCase

@end

BOOL shouldUseLowerBoundChoices_mh[25];
int rIdx_mh;

uint monsterHelper_mockRandom(uint range){
    return shouldUseLowerBoundChoices_mh[rIdx_mh++]?0:(range-1);
}

#define SET_UP_BOUND() shouldUseLowerBoundChoices_mh[i++] = NO
#define SET_LOW_BOUND() shouldUseLowerBoundChoices_mh[i++] = YES

@implementation MonsterHelperTest

    - (void)setUp {
        [super setUp];
        ASSERT_IS_TEST();
        rIdx_mh = 0;
        randomUInt = &monsterHelper_mockRandom;
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }

    -(void)testConstructEmpty{
        Monster *m = [Monster constructEmptyMonster];
        XCTAssertNotNil(m);
    }
    
    -(void)testMonsterOrder{
        NSArray<NSString *> *ml = [[SingletonCluster getSharedInstance].monsterInfoDictionary getMonsterKeyList:@"NEBULA"];
        XCTAssertTrue([ml[0] isEqualToString:@"DUST_FAIRY"]);
        XCTAssertTrue([ml[1] isEqualToString:@"LOST_SAT"]);
        XCTAssertTrue([ml[2] isEqualToString:@"SENTIENT_CLOUD"]);
        XCTAssertTrue([ml[3] isEqualToString:@"CLOUD_FORTRESS"]);
        
        ml = [[SingletonCluster getSharedInstance].monsterInfoDictionary getMonsterKeyList:@"ALL"];
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
        SET_LOW_BOUND();
        SET_UP_BOUND();
        NSString *s = [Monster randomMonsterKey:@"NEBULA"];
        XCTAssertTrue([s isEqualToString:@"DUST_FAIRY"]);
        s = [Monster randomMonsterKey:@"NEBULA"];
        XCTAssertTrue([s isEqualToString:@"PIRATES"]);
        
    }
    
    -(void)testConstructRandomMonster{
        int i =0;
        SET_LOW_BOUND();
        SET_LOW_BOUND();
        Monster *m = [Monster constructRandomMonster:@"NEBULA" AroundLvl:32];
        XCTAssertTrue([m.fullName isEqualToString:@"Dust Fairy"]);
        XCTAssertEqual(m.lvl,22);
        XCTAssertEqual(m.maxHp,400);
        XCTAssertEqual(m.nowHp,400);
        
        SET_LOW_BOUND();
        SET_UP_BOUND();
        m = [Monster constructRandomMonster:@"NEBULA" AroundLvl:32];
        XCTAssertTrue([m.fullName isEqualToString:@"Dust Fairy"]);
        XCTAssertEqual(m.lvl,42);
        XCTAssertEqual(m.maxHp,650);
        XCTAssertEqual(m.nowHp,650);
        
        SET_UP_BOUND();
        SET_LOW_BOUND();
        m = [Monster constructRandomMonster:@"NEBULA" AroundLvl:32];
        XCTAssertTrue([m.fullName isEqualToString:@"Petty Space Pirates"]);
        XCTAssertEqual(m.lvl,22);
        XCTAssertEqual(m.maxHp,160);
        XCTAssertEqual(m.nowHp,160);
        
        SET_UP_BOUND();
        SET_UP_BOUND();
        m = [Monster constructRandomMonster:@"NEBULA" AroundLvl:32];
        XCTAssertTrue([m.fullName isEqualToString:@"Petty Space Pirates"]);
        XCTAssertEqual(m.lvl,42);
        XCTAssertEqual(m.maxHp,260);
        XCTAssertEqual(m.nowHp,260);
    }
    

@end
