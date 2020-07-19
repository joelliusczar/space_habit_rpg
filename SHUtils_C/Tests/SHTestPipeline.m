//
//  SHTestPipeline.m
//  SHUtils_CTests
//
//  Created by Joel Pridgen on 7/18/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHPipeline.h"
#import "SHDynamicArray.h"

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


static bool _filterAll(int32_t num, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx; (void)num;
	return false;
}

-(void)testFilterEverything {
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
	struct SHPipeline *pl2 = SH_pipeline_useFilter(pl, (bool (*)(void*, void*, uint64_t))_filterAll, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 0);
	XCTAssertEqual(iter, NULL);
}


static bool _filterNone(int32_t num, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx; (void)num;
	return true;
}


-(void)testFilterNone {
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
	struct SHPipeline *pl2 = SH_pipeline_useFilter(pl, (bool (*)(void*, void*, uint64_t))_filterNone, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
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


static int32_t _double(int32_t num, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx; ;
	return num * 2;
}


-(void)testTransform {
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
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_double, NULL, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 14);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 10);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 28);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 24);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 18);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 130);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 134);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 46);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 8);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 30);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 50);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 142);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 62);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 88);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 16);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 186);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 6);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 22);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 176);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 44);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 180);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 54);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 96);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 72);
	XCTAssertEqual(iter, NULL);
	
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


-(void)testFilterThenTransform {
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
	struct SHPipeline *pl3 = SH_pipeline_useTransform(pl2, (void* (*)(void*,void*,uint64_t))_double, NULL, NULL, NULL);
	XCTAssertNotEqual(pl3, NULL);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl3);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 28);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 24);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 8);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 88);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 16);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 176);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 44);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 180);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 96);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 72);
	
	XCTAssertEqual(iter, NULL);
}


static int32_t _triple(int32_t num, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx;
	return num * 3;
}


-(void)testTransformThenFilter {
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
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_triple, NULL, NULL, NULL);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipeline *pl3 = SH_pipeline_useFilter(pl2, (bool (*)(void*, void*, uint64_t))_filterOdds, NULL, NULL);
	XCTAssertNotEqual(pl3, NULL);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl3);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 42);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 18);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 36);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 12);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 132);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 24);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 264);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 66);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 270);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 144);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 108);
	
	XCTAssertEqual(iter, NULL);
}

struct _obj {
	int32_t val;
};


struct _trObj {
	char *myword;
};


struct _testSource2 {
	struct _obj *arr;
	int32_t size;
	int32_t idx;
};



static struct _obj *_objGenFn(struct _testSource2 *source, bool *hasNext) {
	struct _obj *item = &source->arr[source->idx];
	source->idx++;
	if(source->idx >= source->size) *hasNext = false;
	return item;
}

static struct _trObj *_trFn(struct _obj *o, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx;
	char *aword = malloc(sizeof(char) * 25);
	sprintf(aword, "%d", o->val * 2);
	struct _trObj *tr = malloc(sizeof(struct _trObj));
	tr->myword = aword;
	return tr;
}


static void _cleanupTr(struct _trObj **trP2) {
	if(!trP2) return;
	struct _trObj *tr = *trP2;
	if(!tr) return;
	free(tr->myword);
	free(tr);
	*trP2 = NULL;
}





-(void)testTransformObj {
	struct _obj nums[25] = {
		{ .val = 7 }, { .val = 5 }, { .val = 14 }, { .val = 6 }, { .val = 12 }, { .val = 9 }, { .val = 65 },
		{ .val = 67 }, { .val = 23 }, { .val = 4 },
		{ .val = 15 }, { .val = 25 }, { .val = 71 }, { .val = 31 }, { .val = 44 }, { .val = 8 }, { .val = 93 },
		{ .val = 3 }, { .val = 11 }, { .val = 88 }, { .val = 22 },
		{ .val = 90 }, { .val = 27 }, { .val = 48 }, { .val = 36 }
	};
	struct _testSource2 source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_objGenFn, NULL);
	XCTAssertNotEqual(pl, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_trFn, NULL, NULL, (void (*)(void**))_cleanupTr);
	XCTAssertNotEqual(pl2, NULL);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl2);
	XCTAssertNotEqual(iter, NULL);
	struct _trObj *ans = SH_pipelineIterator_next(&iter);
	
	int32_t cmp = strncmp(ans->myword, "14", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "10", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "28", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "12", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "24", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "18", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "130", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "134", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "46", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "8", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "30", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "50", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "142", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "62", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "88", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "16", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "186", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword ,"6", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "22", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "176", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "44", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "180", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "54", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "96", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "72", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	XCTAssertEqual(iter, NULL);
	
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


-(void)testSkipAndTake {
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
	struct SHPipeline *pl2 = SH_pipeline_useSkip(pl,5);
	struct SHPipeline *pl3 = SH_pipeline_useTake(pl2, 5);
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl3);
	XCTAssertNotEqual(iter, NULL);
	int32_t ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 9);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 65);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 67);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 23);
	ans = (int32_t)SH_pipelineIterator_next(&iter);
	XCTAssertEqual(ans, 4);
	XCTAssertEqual(iter, NULL);
	
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


-(void)testTransformObjSkipAndTake {
	struct _obj nums[25] = {
		{ .val = 7 }, { .val = 5 }, { .val = 14 }, { .val = 6 }, { .val = 12 }, { .val = 9 }, { .val = 65 },
		{ .val = 67 }, { .val = 23 }, { .val = 4 },
		{ .val = 15 }, { .val = 25 }, { .val = 71 }, { .val = 31 }, { .val = 44 }, { .val = 8 }, { .val = 93 },
		{ .val = 3 }, { .val = 11 }, { .val = 88 }, { .val = 22 },
		{ .val = 90 }, { .val = 27 }, { .val = 48 }, { .val = 36 }
	};
	struct _testSource2 source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_objGenFn, NULL);
	XCTAssertNotEqual(pl, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_trFn, NULL, NULL,
		(void (*)(void**))_cleanupTr);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipeline *pl3 = SH_pipeline_useSkip(pl2, 5);
	struct SHPipeline *pl4 = SH_pipeline_useTake(pl3, 5);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl4);
	XCTAssertNotEqual(iter, NULL);
	struct _trObj *ans = SH_pipelineIterator_next(&iter);
	
	int32_t cmp = strncmp(ans->myword, "18", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "130", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "134", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "46", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	ans = SH_pipelineIterator_next(&iter);
	
	cmp = strncmp(ans->myword, "8", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	XCTAssertEqual(iter, NULL);
	
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


static bool _filter3digits(struct _trObj *tr, void *fnArgs, uint64_t idx) {
	(void)fnArgs; (void)idx;
	return strlen(tr->myword) < 3;
}


-(void)testTransformThenFilterObj {
	struct _obj nums[25] = {
		{ .val = 7 }, { .val = 5 }, { .val = 14 }, { .val = 6 }, { .val = 12 }, { .val = 9 }, { .val = 65 },
		{ .val = 67 }, { .val = 23 }, { .val = 4 },
		{ .val = 15 }, { .val = 25 }, { .val = 71 }, { .val = 31 }, { .val = 44 }, { .val = 8 }, { .val = 93 },
		{ .val = 3 }, { .val = 11 }, { .val = 88 }, { .val = 22 },
		{ .val = 90 }, { .val = 27 }, { .val = 48 }, { .val = 36 }
	};
	struct _testSource2 source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_objGenFn, NULL);
	XCTAssertNotEqual(pl, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_trFn, NULL, NULL, (void (*)(void**))_cleanupTr);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipeline *pl3 = SH_pipeline_useFilter(pl2, (bool (*)(void*, void*, uint64_t))_filter3digits, NULL, NULL);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl3);
	XCTAssertNotEqual(iter, NULL);
	struct _trObj *ans = SH_pipelineIterator_next(&iter);
	
	int32_t cmp = strncmp(ans->myword, "14", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "10", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "28", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "12", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "24", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "18", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "46", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "8", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "30", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "50", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "62", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "88", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "16", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword ,"6", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "22", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "44", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "54", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "96", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	ans = SH_pipelineIterator_next(&iter);
	cmp = strncmp(ans->myword, "72", 25);
	XCTAssertEqual(cmp, 0);
	_cleanupTr(&ans);
	
	XCTAssertEqual(iter, NULL);
	SH_pipeline_cleanup(&pl);
	XCTAssertEqual(pl, NULL);
}


static int32_t _groupingFn(struct _trObj *tr, void *obj, uint64_t idx) {
	(void)obj; (void)idx;
	return (int32_t)strlen(tr->myword);
}

-(void)testTransformObjThenGroup {
	struct _obj nums[25] = {
		{ .val = 7 }, { .val = 5 }, { .val = 14 }, { .val = 6 }, { .val = 12 }, { .val = 9 }, { .val = 65 },
		{ .val = 67 }, { .val = 23 }, { .val = 4 },
		{ .val = 15 }, { .val = 25 }, { .val = 71 }, { .val = 31 }, { .val = 44 }, { .val = 8 }, { .val = 93 },
		{ .val = 3 }, { .val = 11 }, { .val = 88 }, { .val = 22 },
		{ .val = 90 }, { .val = 27 }, { .val = 48 }, { .val = 36 }
	};
	struct _testSource2 source = {
		.arr = nums,
		.size = 25
	};
	struct SHPipeline *pl = SH_pipeline_init(&source, (void *(*)(void*,bool*))_objGenFn, NULL);
	XCTAssertNotEqual(pl, NULL);
	struct SHPipeline *pl2 = SH_pipeline_useTransform(pl, (void* (*)(void*,void*,uint64_t))_trFn, NULL, NULL, (void (*)(void**))_cleanupTr);
	XCTAssertNotEqual(pl2, NULL);
	struct SHPipeline *pl3 = SH_pipeline_useGrouping(pl2, (void* (*)(void*, void*, uint64_t))_groupingFn, NULL, NULL,
		&arraySetup, NULL, NULL, (void (*)(void**))_cleanupTr);
	
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pl3);
	XCTAssertNotEqual(iter, NULL);
	struct SHIterableWrapper *array = SH_pipelineIterator_next(&iter);
	struct _trObj *ans = SH_iterable_getItemAtIdx(array, 0);
	
	int32_t cmp = strncmp(ans->myword, "14", 25);
	XCTAssertEqual(cmp, 0);
	
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "10", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "28", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "12", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "24", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "18", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "130", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "134", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "46", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "8", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "30", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "50", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "142", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "62", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "88", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "16", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "186", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword ,"6", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "22", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "176", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "44", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "180", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "54", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "96", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	ans = SH_pipelineIterator_next(&iter);
//
//	cmp = strncmp(ans->myword, "72", 25);
//	XCTAssertEqual(cmp, 0);
//	_cleanupTr(&ans);
//	XCTAssertEqual(iter, NULL);
//
//	SH_pipeline_cleanup(&pl);
//	XCTAssertEqual(pl, NULL);
}

@end
