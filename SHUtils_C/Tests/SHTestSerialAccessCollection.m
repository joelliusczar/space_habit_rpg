//
//  SHTestSerialAccessCollection.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/22/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialAccessCollection.h"
#include "SHIterableWrapper.h"
#include "SHUtilConstants.h"
#import <XCTest/XCTest.h>


@interface SHTestSerialAccessCollection : XCTestCase

@end

static int32_t _numCompare(void *a, void *b) {
	int32_t num1 = *((int32_t *)a);
	int32_t num2 = *((int32_t *)b);
	return num2 - num1;
}

@implementation SHTestSerialAccessCollection

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testSerialCollectionOps {
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	struct SHIterableWrapper *collection = SH_iterable_initAsTree(_numCompare, NULL);
	struct SHSerialAccessCollection *serialCollection = SH_SACollection_init(collection);
	
	SHErrorCode status = SH_NO_ERROR;
	status = SH_SACollection_addItem(serialCollection, &nums[0]);
	XCTAssertEqual(status, SH_NO_ERROR);
	void *resultP = NULL;
	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
	XCTAssertEqual(status, SH_PRECONDITIONS_NOT_FULFILLED);
	SH_SACollection_startLoop(serialCollection);
	uint64_t count = SH_NOT_FOUND;
	status = SH_SACollection_count(serialCollection, &count);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(count, 1);
	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 43);
	status = SH_SACollection_closeLoop(serialCollection);
	XCTAssertEqual(status, SH_NO_ERROR);
	int32_t i = 1;
	for(; i < 12; i++) {
		if((status = SH_SACollection_addItem(serialCollection, &nums[i])) != SH_NO_ERROR) {
			break;
		}
	}
	XCTAssertEqual(i, 12);
	count = SH_NOT_FOUND;
	status = SH_SACollection_count(serialCollection, &count);
	XCTAssertEqual(status, SH_PRECONDITIONS_NOT_FULFILLED);
	status = SH_SACollection_startLoop(serialCollection);
	XCTAssertEqual(status, SH_NO_ERROR);
	status = SH_SACollection_count(serialCollection, &count);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(count, 1);
	i = 1;
	for(; i < 12; i++) {
		if((status = SH_SACollection_addItem(serialCollection, &nums[i])) != SH_NO_ERROR) {
			break;
		}
	}
	XCTAssertEqual(i, 12);
	count = SH_NOT_FOUND;
	status = SH_SACollection_count(serialCollection, &count);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(count, 12);
	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 6);
	status = SH_SACollection_getItemAtIdx(serialCollection, 1, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 8);
	status = SH_SACollection_getItemAtIdx(serialCollection, 2, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 9);
	status = SH_SACollection_getItemAtIdx(serialCollection, 3, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 18);
	status = SH_SACollection_getItemAtIdx(serialCollection, 4, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 20);
	status = SH_SACollection_getItemAtIdx(serialCollection, 5, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 21);
	status = SH_SACollection_getItemAtIdx(serialCollection, 6, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 22);
	status = SH_SACollection_getItemAtIdx(serialCollection, 7, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 43);
	status = SH_SACollection_getItemAtIdx(serialCollection, 8, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 50);
	status = SH_SACollection_getItemAtIdx(serialCollection, 9, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 51);
	status = SH_SACollection_getItemAtIdx(serialCollection, 10, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 62);
	status = SH_SACollection_getItemAtIdx(serialCollection, 11, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(*((int32_t*)resultP), 63);
	
	status = SH_SACollection_closeLoop(serialCollection);
	XCTAssertEqual(status, SH_NO_ERROR);
}


-(void)testDeleteFromSerialAccessCollection {
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	struct SHIterableWrapper *collection = SH_iterable_initAsTree(_numCompare, NULL);
	struct SHSerialAccessCollection *serialCollection = SH_SACollection_init(collection);
	uint64_t count = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	SH_SACollection_startLoop(serialCollection);
	int32_t i = 0;
	for(; i < 12; i++) {
		if((status = SH_SACollection_addItem(serialCollection, &nums[i])) != SH_NO_ERROR) {
			break;
		}
	}
	XCTAssertEqual(i, 12);
	count = SH_NOT_FOUND;
	status = SH_SACollection_count(serialCollection, &count);
	printf("test level: delete op\n");
	status = SH_SACollection_deleteItemAtIdx(serialCollection, 5);
	void *resultP = NULL;
//	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 6);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 1, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 8);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 2, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 9);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 3, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 18);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 4, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 20);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 5, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 22);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 6, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 43);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 7, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 50);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 8, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 51);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 9, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 62);
//	status = SH_SACollection_getItemAtIdx(serialCollection, 10, &resultP);
//	XCTAssertEqual(status, SH_NO_ERROR);
//	XCTAssertEqual(*((int32_t*)resultP), 63);

}



@end
