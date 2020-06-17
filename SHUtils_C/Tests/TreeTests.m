//
//  Tests.m
//  Tests
//
//  Created by Joel Pridgen on 6/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#import <XCTest/XCTest.h>

@interface TreeTests : XCTestCase

@end

@implementation TreeTests

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


-(void)testTree {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	XCTAssertEqual(SH_tree_count(tree), 0);
	
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	SH_tree_addItem(tree, &nums[0]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(SH_tree_count(tree), 1);
	XCTAssertEqual(*result, 7);
	XCTAssertNotEqual(iter, NULL);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(result, NULL);
	XCTAssertEqual(iter, NULL);
	SH_tree_addItem(tree, &nums[1]);
	XCTAssertEqual(SH_tree_count(tree), 2);
	SH_tree_addItem(tree, &nums[2]);
	XCTAssertEqual(SH_tree_count(tree), 3);
	SH_tree_addItem(tree, &nums[3]);
	XCTAssertEqual(SH_tree_count(tree), 4);
	SH_tree_addItem(tree, &nums[4]);
	XCTAssertEqual(SH_tree_count(tree), 5);
	SH_tree_addItem(tree, &nums[5]);
	XCTAssertEqual(SH_tree_count(tree), 6);
	SH_tree_addItem(tree, &nums[6]);
	XCTAssertEqual(SH_tree_count(tree), 7);
	SH_tree_addItem(tree, &nums[7]);
	XCTAssertEqual(SH_tree_count(tree), 8);
	SH_tree_addItem(tree, &nums[8]);
	XCTAssertEqual(SH_tree_count(tree), 9);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testPostOrder {
	
}


@end
