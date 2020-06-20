//
//  SHTestRandomTreeFuncs.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 6/19/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#include "SHGenAlgos.h"
#include "SHUtilConstants.h"
#import <XCTest/XCTest.h>

@interface SHTestRandomTreeFuncs : XCTestCase

@end

static int32_t nullBreak = -1;
static int32_t lnBreak = -2;

static int32_t _numCompare(void *a, void *b) {
	int32_t num1 = *((int32_t *)a);
	int32_t num2 = *((int32_t *)b);
	return num2 - num1;
}

static char * _itemStr(void *item) {
	if(!item) return NULL;
	int32_t num = *((int32_t*)item);
	if(num == lnBreak) {
		return SH_constStrCopy("\n");
	}
	if(num == nullBreak) {
		return SH_constStrCopy("X, ");
	}
	char *str = malloc(sizeof(char) * 14 + SH_NULL_CHAR_OFFSET);
	sprintf(str, "%d, ",num);
	return str;
}

@implementation SHTestRandomTreeFuncs

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

-(void)testTreePrint {
	struct SHTree *tree = SH_tree_init(_numCompare, NULL);
	int32_t nums[12] = { 43, 18, 22, 9, 21, 6, 8, 20, 63, 50, 62, 51 };
	
	SH_tree_setLineBreakSentinel(tree, &lnBreak);
	SH_tree_setNullItemSentinel(tree, &nullBreak);
	
	for(int32_t i = 0; i < 12; i++) {
		SH_tree_addItem(tree, &nums[i]);
	}
	
	char *desc = SH_tree_printLineOrder(tree, _itemStr);
	printf("%s\n",desc);
}

@end
