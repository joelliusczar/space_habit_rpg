//
//  SHTestTreeDeleteRoots.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#include "SHUtilConstants.h"
#include "SHGenAlgos.h"
#include "SHPrintTree.h"
#import <XCTest/XCTest.h>

@interface SHTestTreeDeleteRoots : XCTestCase

@end


static int32_t _numCompare(void *a, void *b) {
	int32_t num1 = *((int32_t *)a);
	int32_t num2 = *((int32_t *)b);
	return num2 - num1;
}


@implementation SHTestTreeDeleteRoots

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testDeleteRoot1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
		result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}

@end
