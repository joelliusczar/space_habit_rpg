//
//  SHTestTreeDelete.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/18/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#import <XCTest/XCTest.h>

@interface SHTestTreeDelete : XCTestCase

@end

@implementation SHTestTreeDelete


static int32_t _numCompare(void *a, void *b) {
	int32_t num1 = *((int32_t *)a);
	int32_t num2 = *((int32_t *)b);
	return num2 - num1;
}

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testTreeDelete1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
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


-(void)testTreeDelete2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
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


-(void)testTreeDelete3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
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


-(void)testTreeDelete4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
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


-(void)testTreeDelete5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}

-(void)testTreeDelete8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 2);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete11 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testTreeDelete12 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 4);
	SH_tree_deleteNthItem(tree, 5);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 0);
	SH_tree_deleteNthItem(tree, 2);
	SH_tree_deleteNthItem(tree, 1);
	SH_tree_deleteNthItem(tree, 0);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}
@end
