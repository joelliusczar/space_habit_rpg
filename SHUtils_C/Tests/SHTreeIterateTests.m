//
//  Tests.m
//  Tests
//
//  Created by Joel Pridgen on 6/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#import <XCTest/XCTest.h>

@interface SHTreeIterateTests : XCTestCase

@end

@implementation SHTreeIterateTests

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
	
	SH_tree_addItem(tree, &nums[9]);
	XCTAssertEqual(SH_tree_count(tree), 10);
	SH_tree_addItem(tree, &nums[10]);
	XCTAssertEqual(SH_tree_count(tree), 11);
	SH_tree_addItem(tree, &nums[11]);
	XCTAssertEqual(SH_tree_count(tree), 12);
	SH_tree_addItem(tree, &nums[12]);
	XCTAssertEqual(SH_tree_count(tree), 13);
	SH_tree_addItem(tree, &nums[13]);
	XCTAssertEqual(SH_tree_count(tree), 14);
	SH_tree_addItem(tree, &nums[14]);
	XCTAssertEqual(SH_tree_count(tree), 15);
	SH_tree_addItem(tree, &nums[15]);
	XCTAssertEqual(SH_tree_count(tree), 16);
	SH_tree_addItem(tree, &nums[16]);
	XCTAssertEqual(SH_tree_count(tree), 17);
	SH_tree_addItem(tree, &nums[17]);
	XCTAssertEqual(SH_tree_count(tree), 18);
	SH_tree_addItem(tree, &nums[18]);
	XCTAssertEqual(SH_tree_count(tree), 19);
	SH_tree_addItem(tree, &nums[19]);
	XCTAssertEqual(SH_tree_count(tree), 20);
	SH_tree_addItem(tree, &nums[20]);
	XCTAssertEqual(SH_tree_count(tree), 21);
	SH_tree_addItem(tree, &nums[21]);
	XCTAssertEqual(SH_tree_count(tree), 22);
	SH_tree_addItem(tree, &nums[22]);
	XCTAssertEqual(SH_tree_count(tree), 23);
	SH_tree_addItem(tree, &nums[23]);
	XCTAssertEqual(SH_tree_count(tree), 24);
	SH_tree_addItem(tree, &nums[24]);
	XCTAssertEqual(SH_tree_count(tree), 25);
	
	
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 3);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 11);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 36);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 48);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 90);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextInorder(&iter);
	XCTAssertEqual(result, NULL);
	
	SH_tree_cleanup(tree);
	
}


-(void)testLineAndPostOrder {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	int32_t nullBreak = -1;
	int32_t lnBreak = -2;
	
	SH_tree_setLineBreakSentinel(tree, &lnBreak);
	SH_tree_setNullItemSentinel(tree, &nullBreak);
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);

	SH_tree_addItem(tree, &nums[2]);

	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);


	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);


	SH_tree_addItem(tree, &nums[3]);

	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);


	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPost2 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	int32_t nullBreak = -1;
	int32_t lnBreak = -2;
	
	SH_tree_setLineBreakSentinel(tree, &lnBreak);
	SH_tree_setNullItemSentinel(tree, &nullBreak);
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, nullBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPost3 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	int32_t lnBreak = -2;
	
	SH_tree_setLineBreakSentinel(tree, &lnBreak);
	SH_tree_setNullItemSentinel(tree, NULL);
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, lnBreak);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPost4 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	SH_tree_setLineBreakSentinel(tree, NULL);
	SH_tree_setNullItemSentinel(tree, NULL);
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPost5 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
	SH_tree_addItem(tree, &nums[0]);
	SH_tree_addItem(tree, &nums[1]);
	SH_tree_addItem(tree, &nums[2]);
	SH_tree_addItem(tree, &nums[3]);
	SH_tree_addItem(tree, &nums[4]);
	SH_tree_addItem(tree, &nums[5]);
	SH_tree_addItem(tree, &nums[6]);
	SH_tree_addItem(tree, &nums[7]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPost6 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result,  9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
	
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineorder7 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	int32_t* result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testLineAndPre8 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	int32_t *result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
	
	iter = SH_treeIterator_init(tree);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate9 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	int32_t *result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate10 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	
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
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate11 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	
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
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate12 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	
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
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate13 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	
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
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate14 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	
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
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate15 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	
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
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate16 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate17 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate18 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPreorderIterate19 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
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


-(void)testAddAndPreorderIterate20 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	SH_tree_addItem(tree, &nums[22]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
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


-(void)testAddAndPreorderIterate21 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	SH_tree_addItem(tree, &nums[22]);
	SH_tree_addItem(tree, &nums[23]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 44);
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


-(void)testAddAndPreorderIterate22 {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	SH_tree_addItem(tree, &nums[22]);
	SH_tree_addItem(tree, &nums[23]);
	SH_tree_addItem(tree, &nums[24]);
	
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
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPreorder(&iter);
	XCTAssertEqual(*result, 27);
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


-(void)testLineOrderFullTree {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	SH_tree_addItem(tree, &nums[22]);
	SH_tree_addItem(tree, &nums[23]);
	SH_tree_addItem(tree, &nums[24]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t *result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 90);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 3);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 11);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 36);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(*result, 48);
	result = (int32_t *)SH_treeIterator_nextLineOrder(&iter);
	XCTAssertEqual(result, NULL);
}


-(void)testAddAndPostIterateFullTree {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	
	
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
	SH_tree_addItem(tree, &nums[12]);
	SH_tree_addItem(tree, &nums[13]);
	SH_tree_addItem(tree, &nums[14]);
	SH_tree_addItem(tree, &nums[15]);
	SH_tree_addItem(tree, &nums[16]);
	SH_tree_addItem(tree, &nums[17]);
	SH_tree_addItem(tree, &nums[18]);
	SH_tree_addItem(tree, &nums[19]);
	SH_tree_addItem(tree, &nums[20]);
	SH_tree_addItem(tree, &nums[21]);
	SH_tree_addItem(tree, &nums[22]);
	SH_tree_addItem(tree, &nums[23]);
	SH_tree_addItem(tree, &nums[24]);
	
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	int32_t *result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 3);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 4);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 6);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 5);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 8);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 11);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 12);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 9);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 7);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 22);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 15);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 27);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 25);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 36);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 48);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 44);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 31);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 23);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 67);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 88);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 93);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 90);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 71);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 65);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(*result, 14);
	result = (int32_t *)SH_treeIterator_nextPostOrder(&iter);
	XCTAssertEqual(result, NULL);
}


@end
