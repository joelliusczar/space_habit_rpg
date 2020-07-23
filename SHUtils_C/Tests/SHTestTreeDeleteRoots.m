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


-(void)testDeleteRoot3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
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


-(void)testDeleteRoot4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
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


-(void)testDeleteRoot5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
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


-(void)testDeleteRoot6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot11 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRoot12 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteLeftRoot1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
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


-(void)testDeleteLeftRoot7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
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


-(void)testDeleteLeftRoot8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteLeftRoot9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteLeftRoot10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteLeftRoot11 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteLeftRoot12 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
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
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot11 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteRighttRoot12 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 9);
	SH_tree_deleteNthItem(tree, 8);
	SH_tree_deleteNthItem(tree, 7);
	SH_tree_deleteNthItem(tree, 6);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 3);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testDeleteMyTree1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	for(int32_t i = 0; i < 25; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 15);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t *result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 3);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 11);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 36);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 48);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 90);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}

@end
