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
    
    -(void)testGetSuffix{
        NSString *s = [ZoneHelper getSymbolSuffix:0];
        XCTAssertTrue([s isEqualToString:@""]);
        s = [ZoneHelper getSymbolSuffix:1];
        XCTAssertTrue([s isEqualToString:@"Alpha"]);
        s = [ZoneHelper getSymbolSuffix:9];
        XCTAssertTrue([s isEqualToString:@"November"]);
        s = [ZoneHelper getSymbolSuffix:100];
        XCTAssertTrue([s isEqualToString:@"Zed"]);
        s = [ZoneHelper getSymbolSuffix:101];
        XCTAssertTrue([s isEqualToString:@"Alpha Alpha"]);
        s = [ZoneHelper getSymbolSuffix:102];
        XCTAssertTrue([s isEqualToString:@"Alpha Beta"]);
        s = [ZoneHelper getSymbolSuffix:199];
        XCTAssertTrue([s isEqualToString:@"Alpha Omega"]);
        s = [ZoneHelper getSymbolSuffix:200];
        XCTAssertTrue([s isEqualToString:@"Alpha Zed"]);
        s = [ZoneHelper getSymbolSuffix:201];
        XCTAssertTrue([s isEqualToString:@"Beta Alpha"]);
        s = [ZoneHelper getSymbolSuffix:301];
        XCTAssertTrue([s isEqualToString:@"Cain Alpha"]);
        s = [ZoneHelper getSymbolSuffix:901];
        XCTAssertTrue([s isEqualToString:@"November Alpha"]);
        s = [ZoneHelper getSymbolSuffix:1001];
        XCTAssertTrue([s isEqualToString:@"Kilo Alpha"]);
        s = [ZoneHelper getSymbolSuffix:2001];
        XCTAssertTrue([s isEqualToString:@"Ludwig Alpha"]);
        s = [ZoneHelper getSymbolSuffix:3001];
        XCTAssertTrue([s isEqualToString:@"Zulu Alpha"]);
        s = [ZoneHelper getSymbolSuffix:5001];
        XCTAssertTrue([s isEqualToString:@"Flanders Alpha"]);
        s = [ZoneHelper getSymbolSuffix:8001];
        XCTAssertTrue([s isEqualToString:@"Sparta Alpha"]);
        s = [ZoneHelper getSymbolSuffix:9001];
        XCTAssertTrue([s isEqualToString:@"Superior Alpha"]);
        s = [ZoneHelper getSymbolSuffix:9051];
        XCTAssertTrue([s isEqualToString:@"Superior Berlin"]);
        s = [ZoneHelper getSymbolSuffix:9100];
        XCTAssertTrue([s isEqualToString:@"Superior Zed"]);
        s = [ZoneHelper getSymbolSuffix:9500];
        XCTAssertTrue([s isEqualToString:@"Xs Zed"]);
        s = [ZoneHelper getSymbolSuffix:9800];
        XCTAssertTrue([s isEqualToString:@"Zen Zed"]);
        s = [ZoneHelper getSymbolSuffix:9900];
        XCTAssertTrue([s isEqualToString:@"Apex Zed"]);
        s = [ZoneHelper getSymbolSuffix:9990];
        XCTAssertTrue([s isEqualToString:@"Omega Superior"]);
        s = [ZoneHelper getSymbolSuffix:9995];
        XCTAssertTrue([s isEqualToString:@"Omega Rex"]);
        s = [ZoneHelper getSymbolSuffix:9999];
        XCTAssertTrue([s isEqualToString:@"Omega Omega"]);
        s = [ZoneHelper getSymbolSuffix:10000];
        XCTAssertTrue([s isEqualToString:@"Omega Zed"]);
        s = [ZoneHelper getSymbolSuffix:10001];
        XCTAssertTrue([s isEqualToString:@"Zed Alpha"]);
        s = [ZoneHelper getSymbolSuffix:10101];
        XCTAssertTrue([s isEqualToString:@"Alpha Alpha Alpha"]);
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
