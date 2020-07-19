//
//  SHTestPipeline.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 7/18/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHPipeline.h"

@interface SHTestPipeline : XCTestCase

@end

@implementation SHTestPipeline

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

struct _testSource {
	int32_t *arr;
	int32_t size;
	int32_t idx;
};

static int32_t _genFn(struct _testSource *source, bool *hasNext) {
	int32_t item = source->arr[source->idx];
	source->idx++;
	if(source->idx >= source->size) *hasNext = false;
	return item;
}


static bool _filterOdds(int32_t num, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx;
	return (num & 1) == 0;
}

-(void)testSource {
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	struct _testSource source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_genFn, NULL);
	XCTAssertNotEqual(pl, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 7);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 5);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 14);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 6);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 9);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 65);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 67);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 23);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 4);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 15);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 25);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 71);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 31);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 44);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 8);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 93);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 3);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 11);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 88);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 22);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 90);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 27);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 48);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 36);
	XCTAssertEqual(iter, NULL);
	
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


-(void)testFilter {
	int32_t nums[25] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 88, 22,
		90, 27, 48, 36
	};
	struct _testSource source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_genFn, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useFilter(pl, (bool (*)(void*, void*, uint64_t))_filterOdds, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 14);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 6);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 4);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 44);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 8);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 88);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 22);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 90);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 48);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 36);
	
	XCTAssertEqual(iter, NULL);
}


-(void)testFilter2 {
	int32_t nums[20] = {
		7, 5, 14, 6, 12, 9, 65, 67, 23, 4,
		15, 25, 71, 31, 44, 8, 93, 3, 11, 27
	};
	struct _testSource source = {
		.arr = nums,
		.size = 20
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_genFn, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useFilter(pl, (bool (*)(void*, void*, uint64_t))_filterOdds, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 14);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 6);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 4);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 44);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 8);
	
	XCTAssertEqual(iter, NULL);
}

@end
