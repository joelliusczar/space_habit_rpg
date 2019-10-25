//
//	SHControlKeepTest.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/14/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
@import SHCommon;
#import "TestKeepObject.h"
#import "TestKeepSubject_A.h"
#import "TestKeepSubject_B.h"
#import "TestKeepObjectAlt.h"
#import <objc/runtime.h>


@interface SHControlKeepTest : XCTestCase
@property (strong,nonatomic) SHControlKeep *keep;
@property (copy,nonatomic) SHLazyLoadBlock blockA;
@property (copy,nonatomic) SHLazyLoadBlock nilBlock;
@property (copy,nonatomic) SHLazyLoadBlock blockB;
@property (copy,nonatomic) SHLazyLoadBlock invalidBlock;
@property (copy,nonatomic) SHLazyLoadBlock blockA2;
@property (copy,nonatomic) SHLazyLoadBlock blockKey;
@property (weak,nonatomic) TestKeepSubject_A *designatedWeak;
@property (strong,nonatomic) TestKeepObject *obj;
@end

@implementation SHControlKeepTest

- (void)setUp {
	[super setUp];
	self.keep = [[SHControlKeep alloc] init];
	self.blockA = ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)ext;
		TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
		subA.changer = 0;
		[meep forResponderKey:@"A" doSetupAction:^(id responder){
			subA.delegateA = responder;
		}];
		[meep forResponderKey:@"B" doSetupAction:^(id responder){
			subA.delegateB = responder;
		}];
		[meep forResponderKey:@"C" doSetupAction:^(id responder){
			subA.delegateC = responder;
		}];
		return subA;
	};
	self.blockA2 = ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)ext;
		TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
		subA.changer = 2;
		[meep forResponderKey:@"A" doSetupAction:^(id responder){
			subA.delegateA = responder;
		}];
		[meep forResponderKey:@"B" doSetupAction:^(id responder){
			subA.delegateB = responder;
		}];
		[meep forResponderKey:@"C" doSetupAction:^(id responder){
			subA.delegateC = responder;
		}];
		return subA;
	};
	self.nilBlock = ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)meep;
		(void)ext;
		return nil;
	};
	self.blockB = ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)meep;
		(void)ext;
		TestKeepSubject_B *subB = [[TestKeepSubject_B alloc] init];
		[meep forResponderKey:@"A" doSetupAction:^(id responder){
			subB.delegateA2 = responder;
		}];
		[meep forResponderKey:@"B" doSetupAction:^(id responder){
			subB.delegateB2 = responder;
		}];
		return subB;
	};
	self.blockKey = ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)meep;
		(void)ext;
		TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
		ext.key = @"subA";
		return subA;
	};
	
}

- (void)tearDown {
	self.keep = nil;
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
}


NSHashTable* getSet(SHControlKeep *keep,NSString *key){
	Ivar iv = class_getInstanceVariable(keep.class,"_associations");
	NSDictionary *dict = object_getIvar(keep,iv);
	id assocItem = dict[key];
	Ivar iv2 = class_getInstanceVariable([assocItem class],"_set");
	return object_getIvar(assocItem,iv2);
}


SHLazyLoadBlock getNumberedBlock(int num){
	return ^id(SHControlKeep *meep,SHControlExtent *ext){
		(void)ext;
		TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
		subA.changer = num;
		
		[meep forResponderKey:@"A" doSetupAction:^(id responder){
			subA.delegateA = responder;
		}];
		return subA;
	};
}


-(void)testCount{
	[self.keep addLoaderBlock:self.blockA];
	XCTAssertEqual(self.keep.controlList.count,1);
	[self.keep addLoaderBlock:self.nilBlock];
	[self.keep addLoaderBlock:self.blockB];
	XCTAssertEqual(self.keep.controlList.count,3);
	XCTAssertEqual(self.keep.associatedCount,0);
}


-(void)testNilBlock{
	[self.keep addLoaderBlock:self.nilBlock];
	id result = self.keep.controlList[0];
	XCTAssertNil(result);
	XCTAssertEqual(self.keep.associatedCount,0);
}

-(void)testSubjectNoObject{
	[self.keep addLoaderBlock:self.blockA];
	TestKeepSubject_A *subA = self.keep.controlList[0];
	XCTAssertEqual([subA callGetA],0);
	XCTAssertEqual([subA callGetB],0);
	XCTAssertEqual([subA callGetC],0);
	XCTAssertEqual(self.keep.associatedCount,3);
}

-(void)testPersistency{
	[self.keep addLoaderBlock:self.blockA];
	TestKeepSubject_A *subA = self.keep.controlList[0];
	TestKeepSubject_A *subA2 = self.keep.controlList[0];
	XCTAssertEqual(subA,subA2);
}

-(void)testDuplicateLoader{
	[self.keep addLoaderBlock:self.blockA];
	[self.keep addLoaderBlock:self.blockA];
	TestKeepSubject_A *subA1 = self.keep.controlList[0];
	TestKeepSubject_A *subA2 = self.keep.controlList[1];
	XCTAssertNotEqual(subA1,subA2);
}

-(void)testSubjectLoadThenObject{
	[self.keep addLoaderBlock:self.blockA];
	[self.keep addLoaderBlock:self.blockA2];
	TestKeepSubject_A *subA = self.keep.controlList[0];
	TestKeepSubject_A *subA2 = self.keep.controlList[1];
	TestKeepObject *obj = [[TestKeepObject alloc] init];
	self.keep.responderLookup[@"A"] = obj;
	XCTAssertEqual([subA callGetA],52);
	XCTAssertEqual([subA2 callGetA],54);
	self.keep.responderLookup[@"B"] = obj;
	XCTAssertEqual([subA callGetB],65);
	XCTAssertEqual([subA2 callGetB],67);
	
}

-(TestKeepSubject_A *)loadThenReplaceSetup{
	[self.keep addLoaderBlock:self.blockA];
	TestKeepSubject_A *subA = self.keep.controlList[0];
	self.obj = [[TestKeepObject alloc] init];
	self.keep.responderLookup[@"A"] = self.obj;
	self.keep.responderLookup[@"B"] = self.obj;
	return subA;
}

-(void)testSubjectLoadThenReplaceObjectWithNil{
	TestKeepSubject_A *subA = [self loadThenReplaceSetup];
	XCTAssertEqual([subA callGetA],52);
	XCTAssertEqual([subA callGetB],65);
	self.keep.responderLookup[@"A"] = nil;
	self.keep.responderLookup[@"B"] = nil;
	XCTAssertEqual([subA callGetA],0);
	XCTAssertEqual([subA callGetB],0);
}


-(void)testSubjectLoadThanReplaceObjectWithObject{
	TestKeepSubject_A *subA = [self loadThenReplaceSetup];
	XCTAssertEqual([subA callGetA],52);
	XCTAssertEqual([subA callGetB],65);
	TestKeepObjectAlt *objAlt = [[TestKeepObjectAlt alloc] init];
	self.keep.responderLookup[@"A"] = objAlt;
	XCTAssertEqual([subA callGetA],10);
	XCTAssertEqual([subA callGetB],65);
	self.keep.responderLookup[@"B"] = objAlt;
	XCTAssertEqual([subA callGetA],10);
	XCTAssertEqual([subA callGetB],30);
}


-(void)testSubjectBLoadMissingStuff{
	[self.keep addLoaderBlock:self.blockA];
	TestKeepSubject_A *subA = self.keep.controlList[0];
	XCTAssertEqual([subA callGetC],0);
	TestKeepObject *obj = [[TestKeepObject alloc] init];
	self.keep.responderLookup[@"C"] = obj;
	XCTAssertThrows([subA callGetC]);
}


-(void)testObjectThenAddSubject{
	[self.keep addLoaderBlock:self.blockA];
	TestKeepObject *obj = [[TestKeepObject alloc] init];
	self.keep.responderLookup[@"A"] = obj;
	XCTAssertEqual(self.keep.associatedCount,1);
	self.keep.responderLookup[@"B"] = obj;
	XCTAssertEqual(self.keep.associatedCount,2);
	TestKeepSubject_A *subA = self.keep.controlList[0];
	XCTAssertEqual(self.keep.associatedCount,3);
	XCTAssertEqual([subA callGetA],52);
	XCTAssertEqual([subA callGetB],65);
	XCTAssertEqual([subA callGetC],0);
}


-(void)testMemoryLoopingThroughSet{
	TestKeepObject *obj = [[TestKeepObject alloc] init];
	self.keep.responderLookup[@"setDelegateA:"] = obj;
	int limit = 25;
	for(int i = 0; i < limit;i++){
		[self.keep addLoaderBlock:getNumberedBlock(i)];
	}
	self.keep.responderLookup[@"setDelegateA:"] = nil;
	for(int i = 0;i < limit;i++){
		self.keep.controlList[i] = [[SHVarWrapper<SHLazyLoadBlock> alloc] init:self.nilBlock,nil];

	}
	NSHashTable *set = getSet(self.keep,@":setDelegateA:");

	XCTAssertEqual(set.allObjects.count,0);
	for(NSUInteger i = 0; i < set.allObjects.count;i++){
		TestKeepSubject_A *subA = set.allObjects[i];
		NSLog(@"%ld",subA.changer);
	}
}

-(void)testKeyedControlGet{
	[self.keep addLoaderBlock:self.blockKey withKey:@"subA"];
	id subA1 = self.keep.controlList[0];
	XCTAssertTrue([subA1 isKindOfClass:TestKeepSubject_A.class]);
	id subA2 = self.keep.controlLookup[@"subA"];
	XCTAssertEqual(subA1,subA2);
}

@end
