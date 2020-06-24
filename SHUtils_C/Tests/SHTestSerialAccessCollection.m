//
//  SHTestSerialAccessCollection.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/22/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialAccessCollection.h"
#include "SHIterableWrapper.h"
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
	int32_t result = 0;
	void *resultP = &result;
	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
	XCTAssertEqual(status, SH_PRECONDITIONS_NOT_FULFILLED);
	SH_SACollection_startLoop(serialCollection);
	sleep(1);
	status = SH_SACollection_getItemAtIdx(serialCollection, 0, &resultP);
	XCTAssertEqual(status, SH_NO_ERROR);
	XCTAssertEqual(result, 43);
	resultP = SH_iterable_getItemAtIdx(collection, 0);
	result = *(int32_t *)resultP;
	XCTAssertEqual(result, 43);
}



@end
