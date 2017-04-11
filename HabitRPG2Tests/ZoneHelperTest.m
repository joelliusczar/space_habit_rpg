//
//  ZoneHelperTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SingletonCluster.h"
#import "MockStdLibWrapper.h"
#import "constants.h"
#import "ZoneHelper.h"


@interface ZoneHelperTest : XCTestCase

@end

MockStdLibWrapper *mw;

@implementation ZoneHelperTest

    - (void)setUp {
        [super setUp];
        XCTAssertEqual([SingletonCluster getSharedInstance].EnviromentNum,ENV_UTEST);
        mw = [[MockStdLibWrapper alloc] init];
        [SingletonCluster getSharedInstance].stdLibWrapper =mw;
        
    }
    
    -(void)testgetUnlockedZoneGroupKeys{
        NSArray<NSString *> *t = [ZoneHelper getUnlockedZoneGroupKeys:0];
        XCTAssertEqual(t.count, 1);
        XCTAssertTrue([t[0] isEqualToString:LVL_0_ZONES]);
        t = [ZoneHelper getUnlockedZoneGroupKeys:1];
        XCTAssertEqual(t.count, 1);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:4];
        XCTAssertEqual(t.count, 1);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:5];
        XCTAssertEqual(t.count, 2);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:9];
        XCTAssertEqual(t.count, 2);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:10];
        XCTAssertEqual(t.count, 3);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:14];
        XCTAssertEqual(t.count, 3);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:15];
        XCTAssertEqual(t.count, 4);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:19];
        XCTAssertEqual(t.count, 4);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:20];
        XCTAssertEqual(t.count, 5);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);

        t = [ZoneHelper getUnlockedZoneGroupKeys:24];
        XCTAssertEqual(t.count, 5);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:25];
        XCTAssertEqual(t.count, 6);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
        XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:29];
        XCTAssertEqual(t.count, 6);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
        XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:30];
        XCTAssertEqual(t.count, 7);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
        XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
        XCTAssertTrue([t[6] isEqualToString:LVL_30_ZONES]);
        
        t = [ZoneHelper getUnlockedZoneGroupKeys:1000];
        XCTAssertEqual(t.count, 7);
        XCTAssertTrue([t[0] isEqualToString:LVL_1_ZONES]);
        XCTAssertTrue([t[1] isEqualToString:LVL_5_ZONES]);
        XCTAssertTrue([t[2] isEqualToString:LVL_10_ZONES]);
        XCTAssertTrue([t[3] isEqualToString:LVL_15_ZONES]);
        XCTAssertTrue([t[4] isEqualToString:LVL_20_ZONES]);
        XCTAssertTrue([t[5] isEqualToString:LVL_25_ZONES]);
        XCTAssertTrue([t[6] isEqualToString:LVL_30_ZONES]);
    }
    
    -(void)testGetRandomZoneDefinitionKey{
        __block int32_t i = 0;
        mw.mockRandom = ^uint32_t(uint32_t offset){
            if(i++==0){
                return 1;
            }
            else{
                return 2;
            }
            
        };
        NSString *s = [ZoneHelper getRandomZoneDefinitionKey:10];
        XCTAssertTrue([s isEqualToString:@"UNCHARTED"]);
    }

    - (void)tearDown {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        [super tearDown];
    }

    - (void)testExample {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    - (void)testPerformanceExample {
        // This is an example of a performance test case.
        [self measureBlock:^{
            // Put the code you want to measure the time of here.
        }];
    }

@end
