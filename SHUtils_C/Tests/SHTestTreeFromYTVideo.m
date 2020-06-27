//
//  SHTestTreeFromYTVideo.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/18/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#import <XCTest/XCTest.h>

@interface SHTestTreeFromYTVideo : XCTestCase

@end

@implementation SHTestTreeFromYTVideo

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



-(void)testYTTree1 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	
	
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
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	
	
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
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	SH_tree_addItem(tree, &nums[8]);
	
	
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
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	SH_tree_addItem(tree, &nums[8]);
	SH_tree_addItem(tree, &nums[9]);
	
	
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
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	SH_tree_addItem(tree, &nums[8]);
	SH_tree_addItem(tree, &nums[9]);
	SH_tree_addItem(tree, &nums[10]);
	
	
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
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testYTTree10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	SH_tree_addItem(tree, &nums[8]);
	SH_tree_addItem(tree, &nums[9]);
	SH_tree_addItem(tree, &nums[10]);
	SH_tree_addItem(tree, &nums[11]);
	
	
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


-(void)testYTTreeLineOrder {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	SH_tree_setLineBreakSentinel(tree, NULL);
	SH_tree_setNullItemSentinel(tree, NULL);
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	SH_tree_addItem(tree, &nums[8]);
	SH_tree_addItem(tree, &nums[9]);
	SH_tree_addItem(tree, &nums[10]);
	SH_tree_addItem(tree, &nums[11]);
	
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 18);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 50);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 21);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 43);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 62);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 20);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 51);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 63);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
}


-(void)testTreeCounts {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	uint64_t count = SH_tree_count(tree);
	XCTAssertEqual(count, 12);
}

@end
