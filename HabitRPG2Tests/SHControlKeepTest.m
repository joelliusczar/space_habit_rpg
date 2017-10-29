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
#import <objc/runtime.h>


@interface SHControlKeepTest : XCTestCase
@property (strong,nonatomic) SHControlKeep *keep;
@property (copy,nonatomic) LazyLoadBlock blockA;
@property (copy,nonatomic) LazyLoadBlock nilBlock;
@property (copy,nonatomic) LazyLoadBlock blockB;
@property (copy,nonatomic) LazyLoadBlock invalidBlock;
@property (copy,nonatomic) LazyLoadBlock blockA2;
@property (copy,nonatomic) LazyLoadBlock blockKey;
@property (weak,nonatomic) TestKeepSubject_A *designatedWeak;
@end

@implementation SHControlKeepTest

- (void)setUp {
    [super setUp];
    self.keep = [[SHControlKeep alloc] init];
    self.blockA = ^id(SHControlKeep *meep,ControlExtent *ext){
        TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
        subA.changer = 0;
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateA:)];
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateB:)];
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateC:)];
        return subA;
    };
    self.blockA2 = ^id(SHControlKeep *meep,ControlExtent *ext){
        TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
        subA.changer = 2;
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateA:)];
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateB:)];
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateC:)];
        return subA;
    };
    self.nilBlock = ^id(SHControlKeep *meep,ControlExtent *ext){
        return nil;
    };
    self.blockB = ^id(SHControlKeep *meep,ControlExtent *ext){
        TestKeepSubject_B *subB = [[TestKeepSubject_B alloc] init];
        [meep addControlToActionSet:subB withKey:takeKey(setDelegateA:)];
        [meep addControlToActionSet:subB withKey:takeKey(setDelegateB:)];
        return subB;
    };
    self.invalidBlock = ^id(SHControlKeep *meep,ControlExtent *ext){
        TestKeepSubject_B *subB = [[TestKeepSubject_B alloc] init];
        [meep addControlToActionSet:subB withKey:takeKey(setDelegateC:)];
        return subB;
    };
    self.blockKey = ^id(SHControlKeep *meep,ControlExtent *ext){
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


LazyLoadBlock getNumberedBlock(int num){
    return ^id(SHControlKeep *meep,ControlExtent *ext){
        TestKeepSubject_A *subA = [[TestKeepSubject_A alloc] init];
        subA.changer = num;
        [meep addControlToActionSet:subA withKey:takeKey(setDelegateA:)];
        return subA;
    };
}


-(void)testCount{
    [self.keep addLoaderBlock:self.blockA];
    XCTAssertEqual(self.keep.count,1);
    [self.keep addLoaderBlock:self.nilBlock];
    [self.keep addLoaderBlock:self.blockB];
    XCTAssertEqual(self.keep.count,3);
    XCTAssertEqual(self.keep.associatedCount,0);
}


-(void)testNilBlock{
    [self.keep addLoaderBlock:self.nilBlock];
    id result = self.keep[0];
    XCTAssertNil(result);
    XCTAssertEqual(self.keep.associatedCount,0);
}

-(void)testSubjectNoObject{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepSubject_A *subA = self.keep[0];
    XCTAssertEqual([subA callGetA],0);
    XCTAssertEqual([subA callGetB],0);
    XCTAssertEqual([subA callGetC],0);
    XCTAssertEqual(self.keep.associatedCount,3);
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
    [self.keep addLoaderBlock:self.blockA];
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateA:)] = obj;
    XCTAssertEqual(self.keep.associatedCount,1);
    self.keep[takeKey(setDelegateB:)] = obj;
    XCTAssertEqual(self.keep.associatedCount,2);
    TestKeepSubject_A *subA = self.keep[0];
    XCTAssertEqual(self.keep.associatedCount,3);
    XCTAssertEqual([subA callGetA],52);
    XCTAssertEqual([subA callGetB],65);
    XCTAssertEqual([subA callGetC],0);
}

-(void)testDeprecatedSubjectRelease{
    [self.keep addLoaderBlock:self.blockA];
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateA:)] = obj;
    self.keep[takeKey(setDelegateB:)] = obj;
    TestKeepSubject_A *subA = self.keep[0];
    NSHashTable *set = getSet(self.keep,@":setDelegateA:");
    @autoreleasepool{
        BOOL isInSet = [set containsObject:subA];
        XCTAssertTrue(isInSet);
    }
    subA = nil;
    self.keep[0] = self.nilBlock;
    XCTAssertEqual(set.allObjects.count,0);
}

-(void)testMemoryLoopingThroughSet{
    TestKeepObject *obj = [[TestKeepObject alloc] init];
    self.keep[takeKey(setDelegateA:)] = obj;
    int limit = 25;
    for(int i = 0; i < limit;i++){
        [self.keep addLoaderBlock:getNumberedBlock(i)];
    }
    self.keep[takeKey(setDelegateA:)] = nil;
    for(int i = 0;i < limit;i++){
        self.keep[i] = self.nilBlock;

    }
    NSHashTable *set = getSet(self.keep,@":setDelegateA:");

    XCTAssertEqual(set.allObjects.count,0);
    for(int i = 0; i < set.allObjects.count;i++){
        TestKeepSubject_A *subA = set.allObjects[i];
        NSLog(@"%ld",subA.changer);
    }
}

-(void)testKeyedControlGet{
    [self.keep addLoaderBlock:self.blockKey];
    id subA1 = self.keep[0];
    XCTAssertTrue([subA1 isKindOfClass:TestKeepSubject_A.class]);
    id subA2 = self.keep.specificLookup[@"subA"];
    XCTAssertEqual(subA1,subA2);
}

@end
