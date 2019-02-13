//
//  TestsTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ARCTest.h"
#import "TestKeepSubject_A.h"




//static dispatch_semaphore_t started1;
//static dispatch_semaphore_t started2;
//
//static dispatch_semaphore_t done1;
//static dispatch_semaphore_t done2;
//static dispatch_semaphore_t done3;

@interface TestsTest : XCTestCase
@property (strong,nonatomic) NSObject* obj;
@end

@implementation TestsTest{
  
}

+(void)setUp{
//  started1 = dispatch_semaphore_create(0);
//  started2 = dispatch_semaphore_create(0);
//  done1 = dispatch_semaphore_create(0);
//  done2 = dispatch_semaphore_create(0);
//  done3 = dispatch_semaphore_create(0);
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSomeArcStuff{
    ARCTest *arcTest = [ARCTest new];
    TestKeepSubject_A *subA = [TestKeepSubject_A new];
    arcTest.subA = subA;
    subA = nil;
    XCTAssertNil(arcTest.subA);
}


//-(void)testfastest{
//  dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*1);
//  long done = dispatch_semaphore_wait(started1,t);
//  if(done != 0) @throw [NSException exceptionWithName:@"no signal" reason:nil userInfo:nil];
//  dispatch_semaphore_signal(done1);
//}
//
//-(void)testMedium{
//  dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*1);
//  long timeout = dispatch_semaphore_wait(started2,t);
//  dispatch_semaphore_signal(started1);
//  if(timeout != 0) @throw [NSException exceptionWithName:@"no signal" reason:nil userInfo:nil];
//  dispatch_time_t t2 = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*2);
//  long timeout2 = dispatch_semaphore_wait(done1,t2);
//  dispatch_semaphore_signal(done2);
//  XCTAssert(timeout2 == 0);
//}
//
//-(void)testSlowest{
//  dispatch_semaphore_signal(started2);
//  dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*3);
//  long timeout = dispatch_semaphore_wait(done2,t);
//  dispatch_semaphore_signal(done3);
//}

-(void)testSimpleSemaphoreTest{
  dispatch_semaphore_t sema = dispatch_semaphore_create(0);
  dispatch_semaphore_signal(sema);
  dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*1);
  long result = dispatch_semaphore_wait(sema,t);
  XCTAssertEqual(result, 0);
  dispatch_semaphore_t sema2 = dispatch_semaphore_create(0);
  dispatch_time_t t2 = dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC*1);
  long result2 = dispatch_semaphore_wait(sema2,t2);
  XCTAssertNotEqual(result2, 0);
  
}


-(void)testPtrStrength{
  NSObject* o1 = [NSObject new];
  NSObject* __weak o2 = o1;
  NSObject* o3 = o2;
  o1 = nil;
  XCTAssertNotNil(o2);
  o3 = nil;
  XCTAssertNil(o2);
}

-(void)testBlockAllocStuff{
  NSObject* o1 = [NSObject new];
  NSObject* __weak o2 = o1;
  void (^myblock)(void) = ^void(){
    NSObject* o3 = o1;
    (void)o3;
  };
  (void)myblock;
  o1 = nil;
  XCTAssertNotNil(o2);
}


-(void)testBlockAllocStuff2{
  NSObject* o1 = [NSObject new];
  NSObject* __weak o2 = o1;
  void (^myblock)(void) = ^void(){
    NSObject* o3 = o2;
    (void)o3;
  };
  (void)myblock;
  o1 = nil;
  XCTAssertNil(o2);
}


-(void)testBlockAllocStuff3{
  NSObject* o1 = [NSObject new];
  NSObject* __weak o2 = o1;
  @autoreleasepool {
    void (^myblock)(void) = ^void(){
      NSObject* o3 = o1;
      (void)o3;
    };
    (void)myblock;
  }
  (void)o2;
  
  
  o1 = nil;
  XCTAssertNil(o2);
}


@end
