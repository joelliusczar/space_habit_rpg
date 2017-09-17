//
//  SHControlKeepTest.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SELPtr.h"
#import <XCTest/XCTest.h>
#import "SHControlKeep.h"
#import "TestKeepObject.h"
#import "TestKeepSubject_A.h"
#import "TestKeepSubject_B.h"
#import "TestKeepObjectAlt.h"


@interface SHControlKeepTest : XCTestCase
@property (strong,nonatomic) SHControlKeep *keep;
@property (copy,nonatomic) LazyLoadBlock blockA;
@property (copy,nonatomic) LazyLoadBlock nilBlock;
@property (copy,nonatomic) LazyLoadBlock blockB;
@property (copy,nonatomic) LazyLoadBlock invalidBlock;
@property (copy,nonatomic) LazyLoadBlock blockA2;
@end

@implementation SHControlKeepTest

- (void)setUp {
    [super setUp];
    self.keep = [[SHControlKeep alloc] init];
    self.blockA = ^id(SHControlKeep *meep){
        TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
        subA.changer = 0;
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateA:)];
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateB:)];
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateC:)];
        return subA;
    };
    self.blockA2 = ^id(SHControlKeep *meep){
        TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
        subA.changer = 2;
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateA:)];
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateB:)];
        [meep addSubjectToActionSet:subA withKey:takeKey(setDelegateC:)];
        return subA;
    };
    self.nilBlock = ^id(SHControlKeep *meep){
        return nil;
    };
    self.blockB = ^id(SHControlKeep *meep){
        TestKeepSubject_B *subB = [[TestKeepSubject_B alloc] init];
        [meep addSubjectToActionSet:subB withKey:takeKey(setDelegateA:)];
        [meep addSubjectToActionSet:subB withKey:takeKey(setDelegateB:)];
        return subB;
    };
    self.invalidBlock = ^id(SHControlKeep *meep){
        TestKeepSubject_B *subB = [[TestKeepSubject_B alloc] init];
        [meep addSubjectToActionSet:subB withKey:takeKey(setDelegateC:)];
        return subB;
    };
    
}

- (void)tearDown {
    self.keep = nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testCount{
    [self.keep addLoaderBlock:self.blockA];
    XCTAssertEqual(self.keep.count,1);
    [self.keep addLoaderBlock:self.nilBlock];
    [self.keep addLoaderBlock:self.blockB];
    XCTAssertEqual(self.keep.count,3);
}


-(void)testNilBlock{
    [self.keep addLoaderBlock:self.nilBlock];
    id result = self.keep[0];
    XCTAssertNil(result);
}

-(void)testSubjectNoObject{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA = self.keep[0];
    XCTAssertEqual([subA callGetA],0);
    XCTAssertEqual([subA callGetB],0);
    XCTAssertEqual([subA callGetC],0);
}

-(void)testPersistency{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA = self.keep[0];
    TestKeepSubject_A *subA2 = self.keep[0];
    XCTAssertEqual(subA,subA2);
}

-(void)testDuplicateLoader{
    [self.keep addLoaderBlock:self.blockA];
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA1 = self.keep[0];
    TestKeepSubject_A *subA2 = self.keep[1];
    XCTAssertNotEqual(subA1,subA2);
}

-(void)testSubjectLoadThenObject{
    [self.keep addLoaderBlock:self.blockA];
    [self.keep addLoaderBlock:self.blockA2];
    TestKeepSubject_A *subA = self.keep[0];
    TestKeepSubject_A *subA2 = self.keep[1];
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateA:)] = obj;
    XCTAssertEqual([subA callGetA],52);
    XCTAssertEqual([subA2 callGetA],54);
    self.keep[takeKey(setDelegateB:)] = obj;
    XCTAssertEqual([subA callGetB],65);
    XCTAssertEqual([subA2 callGetB],67);
}

-(TestKeepSubject_A *)loadThenReplaceSetup{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA = self.keep[0];
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateA:)] = obj;
    self.keep[takeKey(setDelegateB:)] = obj;
    return subA;
}

-(void)testSubjectLoadThenReplaceObjectWithNil{
    TestKeepSubject_A *subA = [self loadThenReplaceSetup];
    XCTAssertEqual([subA callGetA],52);
    XCTAssertEqual([subA callGetB],65);
    self.keep[takeKey(setDelegateA:)] = nil;
    self.keep[takeKey(setDelegateB:)] = nil;
    XCTAssertEqual([subA callGetA],0);
    XCTAssertEqual([subA callGetB],0);
}


-(void)testSubjectLoadThanReplaceObjectWithObject{
    TestKeepSubject_A *subA = [self loadThenReplaceSetup];
    XCTAssertEqual([subA callGetA],52);
    XCTAssertEqual([subA callGetB],65);
    TestKeepObjectAlt *objAlt = [[TestKeepObjectAlt alloc] init];
    self.keep[takeKey(setDelegateA:)] = objAlt;
    XCTAssertEqual([subA callGetA],10);
    XCTAssertEqual([subA callGetB],65);
    self.keep[takeKey(setDelegateB:)] = objAlt;
    XCTAssertEqual([subA callGetA],10);
    XCTAssertEqual([subA callGetB],30);
}


-(void)testSubjectBLoadMissingStuff{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA = self.keep[0];
    XCTAssertEqual([subA callGetC],0);
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateC:)] = obj;
    XCTAssertThrows([subA callGetC]);
}


-(void)testObjectThenAddSubject{
    
}

@end
