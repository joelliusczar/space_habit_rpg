//
//  SHSerialQueueTests.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/22/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialQueue.h"
#import <XCTest/XCTest.h>

static int32_t test1 = 0;
static int32_t test2 = 0;
static int32_t test3 = 0;
static int32_t primes[15] = { 1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43 };
static int32_t testSum = 0;


static SHErrorCode _testFunc1(void *args, struct SHQueueStore *store) {
	(void)args; (void)store;
	printf("starting test alpha\n");
	sleep(1);
	test1 = 1;
	printf("ending test alpha\n");
	return SH_NO_ERROR;
}

static SHErrorCode _testFunc2(void *args, struct SHQueueStore *store) {
	(void)args; (void)store;
	printf("starting test bravo\n");
	sleep(1);
	test2 = 1;
	printf("ending test bravo\n");
	return SH_NO_ERROR;
}


static SHErrorCode _testFunc3(void *args, struct SHQueueStore *store) {
	(void)args; (void)store;
	printf("starting test charlie %d\n", test3);
	sleep(1);
	testSum += (primes[test3] * test3);
	
	printf("sum: %d current round: %d prime: %d\n",testSum, test3, primes[test3]);
	printf("ending test charlie%d\n", test3);
	test3++;
	return SH_NO_ERROR;
}

@interface SHSerialQueueTests : XCTestCase

@end

@implementation SHSerialQueueTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testStartAndStop {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = SH_serialQueue_init(NULL, NULL);
	status = SH_serialQueue_closeLoop(queue);
	XCTAssertEqual(status, SH_PRECONDITIONS_NOT_FULFILLED);
	SH_serialQueue_startLoop(queue);
	status = SH_serialQueue_addOp(queue, _testFunc1, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc2, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_closeLoop(queue);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(test1, 1);
	XCTAssertEqual(test2, 1);
}


-(void)testStartAndStop2 {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = SH_serialQueue_init(NULL, NULL);
	SH_serialQueue_startLoop(queue);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_closeLoop(queue);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(testSum, 2872);
}


-(void)testStartAndStop3 {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = SH_serialQueue_init(NULL, NULL);
	SH_serialQueue_startLoop(queue);
	sleep(1);
	printf("test level: now we close\n");
	status = SH_serialQueue_closeLoop(queue);
	XCTAssertEqual(status, SH_NO_ERROR);
}


-(void)testStartAndStop4 {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = SH_serialQueue_init(NULL, NULL);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_serialQueue_addOp(queue, _testFunc3, NULL, NULL);
	XCTAssertEqual(status, SH_NO_ERROR);
	SH_serialQueue_startLoop(queue);
	sleep(1);
	printf("test level: now we close\n");
	status = SH_serialQueue_closeLoop(queue);
	XCTAssertEqual(status, SH_NO_ERROR);
}

@end
