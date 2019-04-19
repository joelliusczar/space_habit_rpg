//
//  TestDumbData.m
//  SHTests
//
//  Created by Joel Pridgen on 3/10/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "DumbDataSaver.h"
#import <objc/runtime.h>
#import <SHModels/SHHero+CoreDataClass.h>
#import <SHCommon/SHCommonUtils.h>
#import <TestCommon/TestHelpers.h>
#import <TestCommon/NSManagedObjectContext+Hijack.h>
#import <XCTest/XCTest.h>
#import <Foundation/NSObjCRuntime.h>

typedef void (*msg_send)(id,SEL);
typedef void (*msg_sendB)(id,SEL,BOOL);
struct flags {
unsigned int _registeredForCallback : 1;
unsigned int _propagatesDeletesAtEndOfEvent : 1;
unsigned int _exhaustiveValidation : 1;
unsigned int _processingChanges : 1;
unsigned int _useCommittedSnapshot : 1;
unsigned int _registeredUndoTransactionID : 1;
unsigned int _retainsAllRegisteredObjects : 1;
unsigned int _savingInProgress : 1;
unsigned int _wasDisposed : 1;
unsigned int _unprocessedChangesPending : 1;
unsigned int _isDirty : 1;
unsigned int _ignoreUndoCheckpoints : 1;
unsigned int _propagatingDeletes : 1;
unsigned int _isNSEditorEditing : 1;
unsigned int _isMainThreadBlessed : 1;
unsigned int _isImportContext : 1;
unsigned int _preflightSaveInProgress : 1;
unsigned int _disableDiscardEditing : 1;
unsigned int _isParentStoreContext : 1;
unsigned int _postSaveNotifications : 1;
unsigned int _isMerging : 1;
unsigned int _concurrencyType : 1;
unsigned int _deleteInaccessible : 1;
unsigned int _priority : 2;
unsigned int _autoMerge : 1;
unsigned int _isXPCServerContext : 1;
unsigned int _pushSecureDelete : 1;
unsigned int _refreshAfterSave : 1;
unsigned int _allowAncillary : 1;
unsigned int _reservedFlags : 2;
} flgs;



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

-(void)dumbDataPrv{
  __weak DumbDataSaver *wdds = nil;
  __weak NSManagedObjectContext*  wcontext = nil;
  @autoreleasepool {
    DumbDataSaver *dds = [DumbDataSaver new];
    wdds = dds;
    dds.writeContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    dds.writeContext.persistentStoreCoordinator = dds.coordinator;
    dds.writeContext.name = @"writer";
    SHHero *h = (SHHero*)[[NSManagedObject alloc] initWithEntity:SHHero.entity insertIntoManagedObjectContext:nil];
    h.lvl = 57;
    h.gold = 112;
    [dds.writeContext performBlockAndWait:^{
      [dds.writeContext insertObject:h];
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
    
    BOOL isDone = shWaitForSema(sema, 1);
    (void)isDone;
    NSFetchRequest<SHHero *> *request = [SHHero fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
    
    NSManagedObjectContext* readContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    wcontext = readContext;
    readContext.persistentStoreCoordinator = dds.coordinator;
    readContext.name = @"reader";
    request.sortDescriptors = @[sortByIsFront];
    __block NSArray<NSManagedObject*> *results = nil;
    [readContext performBlockAndWait:^{
      @autoreleasepool {
        
        NSError *err = nil;
        results = [readContext executeFetchRequest:request error:&err];
      }
    }];
    
    [readContext performBlockAndWait:^{
      @autoreleasepool {
        
        NSError *err = nil;
        results = [readContext executeFetchRequest:request error:&err];
      }
    }];
    NSError *error = nil;
    [dds.coordinator destroyPersistentStoreAtURL:dds.storeURL withType:NSInMemoryStoreType options:nil error:&error];
    
    void* bad = (__bridge void*)readContext;
    CFRelease(bad);

    NSLog(@"%@",readContext);
  }
  XCTAssertNil(wcontext);
  NSLog(@"%@",wdds);
}

- (void)testDumbData {
  
  @autoreleasepool {
    [self dumbDataPrv];
  }
  //for(int i = 0; i < 5; i++){
  
  //}
  NSLog(@"End of test");
}




@end
