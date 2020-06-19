//
//  SHTreeFindItemTests.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/18/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#import <XCTest/XCTest.h>

@interface SHTreeFindItemTests : XCTestCase

@end

@implementation SHTreeFindItemTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


static int32_t _numCompare(void *a, void *b) {
	int32_t num1 = *((int32_t *)a);
	int32_t num2 = *((int32_t *)b);
	return num2 - num1;
}


-(void)testTreeFindItem {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	for(int32_t i = 0; i < 25; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	int32_t *result =  SH_tree_findNthItem(tree, 0);
	XCTAssertEqual(*result, 3);
	result =  SH_tree_findNthItem(tree, 1);
	XCTAssertEqual(*result, 4);
	result =  SH_tree_findNthItem(tree, 2);
	XCTAssertEqual(*result, 5);
	result =  SH_tree_findNthItem(tree, 3);
	XCTAssertEqual(*result, 6);
	result =  SH_tree_findNthItem(tree, 4);
	XCTAssertEqual(*result, 7);
	result =  SH_tree_findNthItem(tree, 5);
	XCTAssertEqual(*result, 8);
	result =  SH_tree_findNthItem(tree, 6);
	XCTAssertEqual(*result, 9);
	result =  SH_tree_findNthItem(tree, 7);
	XCTAssertEqual(*result, 11);
	result =  SH_tree_findNthItem(tree, 8);
	XCTAssertEqual(*result, 12);
	result =  SH_tree_findNthItem(tree, 9);
	XCTAssertEqual(*result, 14);
	result =  SH_tree_findNthItem(tree, 10);
	XCTAssertEqual(*result, 15);
	result =  SH_tree_findNthItem(tree, 11);
	XCTAssertEqual(*result, 22);
	result =  SH_tree_findNthItem(tree, 12);
	XCTAssertEqual(*result, 23);
	result =  SH_tree_findNthItem(tree, 13);
	XCTAssertEqual(*result, 25);
	result =  SH_tree_findNthItem(tree, 14);
	XCTAssertEqual(*result, 27);
	result =  SH_tree_findNthItem(tree, 15);
	XCTAssertEqual(*result, 31);
	result =  SH_tree_findNthItem(tree, 16);
	XCTAssertEqual(*result, 36);
	result =  SH_tree_findNthItem(tree, 17);
	XCTAssertEqual(*result, 44);
	result =  SH_tree_findNthItem(tree, 18);
	XCTAssertEqual(*result, 48);
	result =  SH_tree_findNthItem(tree, 19);
	XCTAssertEqual(*result, 65);
	result =  SH_tree_findNthItem(tree, 20);
	XCTAssertEqual(*result, 67);
	result =  SH_tree_findNthItem(tree, 21);
	XCTAssertEqual(*result, 71);
	result =  SH_tree_findNthItem(tree, 22);
	XCTAssertEqual(*result, 88);
	result =  SH_tree_findNthItem(tree, 23);
	XCTAssertEqual(*result, 90);
	result =  SH_tree_findNthItem(tree, 24);
	XCTAssertEqual(*result, 93);
}

@end
