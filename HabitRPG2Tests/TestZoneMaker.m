//
//  TestZoneMaker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/20/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CoreDataStackController.h"
#import "ZoneMaker.h"

@interface TestZoneMaker : XCTestCase
@property (nonatomic,strong) CoreDataStackController *dataController;
@property (nonatomic,strong) ZoneMaker *zm;
@end

@implementation TestZoneMaker

- (void)setUp {
    [super setUp];
    self.dataController = [[CoreDataStackController alloc] initWithDBFileName:@"testDB.sqlite"];
    self.zm = [[ZoneMaker alloc] initWithDataController:self.dataController];
}

- (void)tearDown {
    [self.dataController deleteAllRecords];
    [super tearDown];
}

-(void)testGetNextUniqueId{
    
}

@end
