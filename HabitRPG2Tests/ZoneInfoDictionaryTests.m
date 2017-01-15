//
//  ZoneInfoDictionaryTests.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZoneInfoDictionary.h"

@interface ZoneInfoDictionaryTests : XCTestCase

@end

@implementation ZoneInfoDictionaryTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

-(void)testGetGroupKeys{
    ZoneInfoDictionary *zid = [ZoneInfoDictionary construct];
    NSArray<NSString*> *keys = [zid getGroupKeyList:@"LVL_1_ZONES"];
    NSSet<NSString*> *keySet = [NSSet setWithArray:keys];
    XCTAssertEqual(keys.count, 4);
    XCTAssertTrue([keySet containsObject:@"GAS"]);
    XCTAssertTrue([keySet containsObject:@"NEBULA"]);
    XCTAssertTrue([keySet containsObject:@"SAFE_SPACE"]);
    XCTAssertTrue([keySet containsObject:@"EMPTY_SPACE"]);
};

-(void)testGetName{
    ZoneInfoDictionary *zid = [ZoneInfoDictionary construct];
    NSString* result = [zid getZoneName:@"GAS"];
    XCTAssertTrue([result isEqualToString:@"Gas Planet Orbit"]);
}

@end
