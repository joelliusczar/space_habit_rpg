//
//  SHInheritanceTreeTest.m
//  SHTests
//
//  Created by Joel Pridgen on 2/16/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SHInheritanceFiles.h"
@import SHCommon;
@import SHTestCommon;

@interface SHInheritanceTreeTest : FrequentCase

@end

@implementation SHInheritanceTreeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}


-(void)testTreeSingleClass {
	SHInheritanceTree *tree = [[SHInheritanceTree<Class, NSString *> alloc] initWithCompareFunction:^BOOL(Class a, Class b){
		return [a isSubclassOfClass: b];
	}];
	
	[tree addObject:@"hoothoot" withKey:SHAlpha.class];
	NSString *match = [tree findMatch:SHAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHBravo.class];
	XCTAssertNil(match);
	match = [tree findMatch:SHAlphaAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphCharlieBravo.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaAlphaAlphaAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaAlphaAlphaBravo.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaBravoBravoAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
}


-(void)testOneLevelTree {
	SHInheritanceTree *tree = [[SHInheritanceTree<Class, NSString *> alloc] initWithCompareFunction:^BOOL(Class a, Class b){
		return [a isSubclassOfClass: b];
	}];
	[tree addObject:@"hoothoot" withKey:SHAlpha.class];
	//[tree addObject:@"derp" withKey:SHAlphaAlpha.class];
	[tree addObject:@"bent" withKey:SHAlphaBravo.class];
	[tree addObject:@"kazoo" withKey:SHAlphaCharlie.class];
	[tree addObject:@"loopzoop" withKey:SHAlphaDelta.class];
	NSString *match = [tree findMatch:SHAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaBravo.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoAlpha.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoBravo.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoBravoAlpha.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoCharlie.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaCharlie.class];
	XCTAssertTrue([match isEqualToString:@"kazoo"]);
	match = [tree findMatch:SHAlphaCharlieAlpha.class];
	XCTAssertTrue([match isEqualToString:@"kazoo"]);
	match = [tree findMatch:SHAlphCharlieBravo.class];
	XCTAssertTrue([match isEqualToString:@"kazoo"]);
	match = [tree findMatch:SHAlphaAlphaAlphaAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaAlphaAlphaBravo.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaDelta.class];
	XCTAssertTrue([match isEqualToString:@"loopzoop"]);
	match = [tree findMatch:SHBravo.class];
	XCTAssertNil(match);
}

-(void)testMultiLevel {
	SHInheritanceTree *tree = [[SHInheritanceTree<Class, NSString *> alloc] initWithCompareFunction:^BOOL(Class a, Class b){
		return [a isSubclassOfClass: b];
	}];
	[tree addObject:@"hoothoot" withKey:SHAlpha.class];
	//[tree addObject:@"derp" withKey:SHAlphaAlpha.class];
	[tree addObject:@"bent" withKey:SHAlphaBravo.class];
	[tree addObject:@"kazoo" withKey:SHAlphaCharlie.class];
	[tree addObject:@"loopzoop" withKey:SHAlphaDelta.class];
	[tree addObject:@"ranty" withKey:SHAlphaBravoBravo.class];
	NSString *match = [tree findMatch:SHAlphaBravo.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoAlpha.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaBravoBravo.class];
	XCTAssertTrue([match isEqualToString:@"ranty"]);
	match = [tree findMatch:SHAlphaBravoBravoAlpha.class];
	XCTAssertTrue([match isEqualToString:@"ranty"]);
	match = [tree findMatch:SHAlphaBravoCharlie.class];
	XCTAssertTrue([match isEqualToString:@"bent"]);
	match = [tree findMatch:SHAlphaAlphaAlphaAlpha.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	match = [tree findMatch:SHAlphaAlphaAlphaBravo.class];
	XCTAssertTrue([match isEqualToString:@"hoothoot"]);
	[tree addObject:@"bottom" withKey:SHAlphaAlphaAlphaAlpha.class];
	match = [tree findMatch:SHAlphaAlphaAlphaAlpha.class];
	XCTAssertTrue([match isEqualToString:@"bottom"]);
	match = [tree findMatch:SHBravo.class];
	XCTAssertNil(match);
}

@end
