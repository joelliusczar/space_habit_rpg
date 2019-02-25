//
//  ZoneTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHModels/ModelConstants.h>
#import <SHModels/Zone+CoreDataClass.h>
#import <SHModels/Zone_Medium.h>

@import TestCommon;

#define SET_UP_BOUND() shouldUseLowerBoundChoices_zh[i++] = NO
#define SET_LOW_BOUND() shouldUseLowerBoundChoices_zh[i++] = YES

@interface ZoneHelperTest2 : FrequentCase

@end



@implementation ZoneHelperTest2
    
- (void)setUp {
    [super setUp];
    ASSERT_IS_TEST();
}

- (void)tearDown {
    [super tearDown];
}


-(void)testGetZone2{
  Zone_Medium* zoneMed = [Zone_Medium newWithDataController:SHData
    withResourceUtil:SharedGlobal.resourceUtility withInfoDict:SharedGlobal.zoneInfoDictionary];
  Zone *z = [zoneMed constructEmptyZone];
  z.isFront = YES;
  z.zoneKey = @"NEBULA";
  Zone *z2 = [zoneMed constructEmptyZone];
  z2.isFront = NO;
  z2.zoneKey = @"GAS";
  [SHData insertIntoContext:z];
  [SHData insertIntoContext:z2];
  dispatch_semaphore_t sema1 = [SHData saveNoWaiting];
  BOOL isDone = waitForSema(sema1, 1);
  XCTAssert(isDone);
  Zone *z3 = [zoneMed getZone:YES];
  XCTAssertTrue(z3.isFront);
  XCTAssertTrue([z3.zoneKey isEqualToString:@"NEBULA"]);
  Zone *z4 = [zoneMed getZone:NO];
  XCTAssertTrue(!z4.isFront);
  XCTAssertTrue([z4.zoneKey isEqualToString:@"GAS"]);
  Zone *z5 = [zoneMed constructEmptyZone];
  z5.isFront = YES;
  z5.zoneKey = @"TEMPLE";
  [SHData insertIntoContext:z5];
  dispatch_semaphore_t sema2 = [SHData saveNoWaiting];
  BOOL isDone2 = waitForSema(sema2, 1);
  XCTAssert(isDone2);
  XCTAssertThrows([zoneMed getZone:YES]);
}


-(void)testMoveToFront2{
  Zone_Medium* zoneMed = [Zone_Medium newWithDataController:SHData
    withResourceUtil:SharedGlobal.resourceUtility withInfoDict:SharedGlobal.zoneInfoDictionary];
  Zone *z0 = [zoneMed constructSpecificZone:HOME_KEY withLvl:1 withMonsterCount:0];;
  [zoneMed moveZoneToFront:z0];
  XCTAssertTrue(z0.isFront);
  [SHData insertIntoContext:z0];
  [SHData saveNoWaiting];

  Zone *z1 = [zoneMed constructEmptyZone];
  z1.zoneKey = @"GAS";
  [zoneMed moveZoneToFront:z1];
  [SHData insertIntoContext:z1];
  [SHData saveNoWaiting];
  
  NSArray<NSManagedObject *> *zones = [zoneMed getAllZones:nil];
  XCTAssertEqual(zones.count, 2);
  XCTAssertTrue(((Zone *)zones[0]).isFront);
  XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
  XCTAssertFalse(((Zone *)zones[1]).isFront);
  XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"HOME"]);
  
  Zone *z2 = [zoneMed constructEmptyZone];
  z2.zoneKey = @"NEBULA";
  [zoneMed moveZoneToFront:z2];
  [SHData insertIntoContext:z2];
  [SHData saveNoWaiting];
  
  zones = [zoneMed getAllZones:nil];
  XCTAssertEqual(zones.count, 2);
  XCTAssertTrue(((Zone *)zones[0]).isFront);
  XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"NEBULA"]);
  XCTAssertFalse(((Zone *)zones[1]).isFront);
  XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"GAS"]);
  
  //these are insync from the database?
  XCTAssertFalse(z1.isFront);
  XCTAssertTrue(z2.isFront);
  
  Zone *z1_1 = (Zone *)zones[1];
  [zoneMed moveZoneToFront:z1_1];
  [SHData insertIntoContext:z1_1];
  [SHData saveNoWaiting];
  
  zones = [zoneMed getAllZones:nil];
  XCTAssertEqual(zones.count, 2);
  XCTAssertTrue(((Zone *)zones[0]).isFront);
  XCTAssertTrue([((Zone *)zones[0]).zoneKey isEqualToString:@"GAS"]);
  XCTAssertFalse(((Zone *)zones[1]).isFront);
  XCTAssertTrue([((Zone *)zones[1]).zoneKey isEqualToString:@"NEBULA"]);
}




@end
