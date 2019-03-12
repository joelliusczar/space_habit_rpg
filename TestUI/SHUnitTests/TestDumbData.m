//
//  TestDumbData.m
//  SHTests
//
//  Created by Joel Pridgen on 3/10/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "DumbDataSaver.h"
#import <SHModels/Zone+CoreDataClass.h>
#import <SHCommon/CommonUtilities.h>
#import <TestCommon/TestHelpers.h>
#import <XCTest/XCTest.h>


@import CoreData;


@interface TestDumbData : XCTestCase

@end

@implementation TestDumbData

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDumbData {
  DumbDataSaver __weak *wdds = nil;
  NSManagedObjectContext* __weak wcontext = nil;
  @autoreleasepool {
    
    DumbDataSaver *dds = [DumbDataSaver new];
    wdds = dds;
    dds.writeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    dds.writeContext.persistentStoreCoordinator = dds.coordinator;
    dds.writeContext.name = @"writer";
    Zone* z1 = (Zone*)[[NSManagedObject alloc] initWithEntity:Zone.entity insertIntoManagedObjectContext:nil];
    z1.isFront = YES;
    z1.zoneKey = @"NEBULA";
    [dds.writeContext performBlockAndWait:^{
      [dds.writeContext insertObject:z1];
    }];
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
  
    [dds.writeContext performBlock:^{
      @autoreleasepool {
        BOOL success;
        NSError *error = nil;
        NSLog(@"In save");
        if(!(success = [dds.writeContext save:&error])){
        }
        dispatch_semaphore_signal(sema);
      }
    }];
    
    BOOL isDone = waitForSema(sema, 1);
    (void)isDone;
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
    
    NSManagedObjectContext* readContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    wcontext = readContext;
    //wdds.readContext = readContext;
    readContext.persistentStoreCoordinator = dds.coordinator;
    readContext.name = @"reader";
    request.sortDescriptors = @[sortByIsFront];
    NSError* __block err = nil;
    NSArray* __block results = nil;
    [dds.readContext performBlockAndWait:^{
      @autoreleasepool {
        results = [readContext executeFetchRequest:request error:&err];
      }
    }];
    NSError *error = nil;
    [dds.readContext reset];
    [dds.coordinator destroyPersistentStoreAtURL:dds.storeURL withType:NSInMemoryStoreType options:nil error:&error];
    id refQue = [TestHelpers getPrivateValue:readContext ivarName:@"_referenceQueue"];
    [TestHelpers setPrivateVar:refQue ivarName:@"_context" newVal:nil];
  }
  XCTAssertNil(wcontext);
  NSLog(@"%@",wdds);
}

-(void)testPersistentContainer{
//  NSPersistentContainer* __weak wc = nil;
//  @autoreleasepool {
//    NSBundle* dumbBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
//    NSURL *modelURL = [dumbBundle URLForResource:@"Model" withExtension:@"momd"];
//
//    NSManagedObjectModel* model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
//    NSPersistentContainer* container = [[NSPersistentContainer alloc] initWithName:@"Test" managedObjectModel:model];
//    wc = container;
//    NSManagedObjectContext* writer = [container newBackgroundContext];
//    Zone* z1 = (Zone*)[[NSManagedObject alloc] initWithEntity:Zone.entity insertIntoManagedObjectContext:nil];
//    z1.isFront = YES;
//    z1.zoneKey = @"NEBULA";
//    [writer performBlockAndWait:^{
//      [writer insertObject:z1];
//    }];
//
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//
//    [writer performBlock:^{
//      @autoreleasepool {
//        BOOL success;
//        NSError *error = nil;
//        NSLog(@"In save");
//        if(!(success = [writer save:&error])){
//        }
//        dispatch_semaphore_signal(sema);
//      }
//    }];
//
//    BOOL isDone = waitForSema(sema, 1);
//    (void)isDone;
//    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
//    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
//
//    NSManagedObjectContext* reader = [container viewContext];
//    request.sortDescriptors = @[sortByIsFront];
//    NSError* __block err = nil;
//    NSArray* __block results = nil;
//    [reader performBlockAndWait:^{
//      @autoreleasepool {
//        results = [reader executeFetchRequest:request error:&err];
//      }
//    }];
//  }
//
}



@end
