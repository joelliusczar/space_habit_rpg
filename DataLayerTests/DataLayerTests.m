//
//  DataLayerTests.m
//  DataLayerTests
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZoneDataController.h"
#import "Zone+CoreDataClass.h"
#import "Hero+CoreDataClass.h"

@interface DataLayerTests : XCTestCase
@property (nonatomic,strong) ZoneDataController *dataController;
@end

@implementation DataLayerTests

- (void)setUp {
    [super setUp];
    self.dataController = [[ZoneDataController alloc] initWithDBFileName:@"entityTestDB.sqlite"];
    Zone *z = [self.dataController constructEmptyZone];
    Zone *nextZone1 = [self.dataController constructEmptyZone];
    Zone *nextZone2 = [self.dataController constructEmptyZone];
    Zone *nextZone3 = [self.dataController constructEmptyZone];
    Zone *prevZone1 = [self.dataController constructEmptyZone];
    Zone *prevZone2 = [self.dataController constructEmptyZone];
    
    [z addNextZonesObject:nextZone1];
    [z addNextZonesObject:nextZone2];
    [z addNextZonesObject:nextZone3];
    z.previousZone = prevZone1;
    prevZone1.previousZone = prevZone2;
    
    Hero *h = (Hero *)[self.dataController constructEmptyEntity:@"Hero"];
    h.zone_link = z;
    
    [self.dataController save];
}

- (void)tearDown {
    [self.dataController deleteAllRecords];
    [super tearDown];
}

-(void)testZoneCreateAndGet{
    Hero *h = (Hero *)[self.dataController getItem:@"Hero" predicate:nil sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"shipName" ascending:YES]]];
    Zone *z = h.zone_link;
    XCTAssertNotNil(z);
    XCTAssertEqual(z.nextZones.count, 3);
    Zone *prevZone1 = z.previousZone;
    XCTAssertNotNil(prevZone1);
    Zone *prevZone2 = prevZone1.previousZone;
    XCTAssertNotNil(prevZone2);
    
}


@end
