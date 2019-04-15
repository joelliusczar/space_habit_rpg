//
//  FrequentCase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/runtime.h>
#import <SHData/SHCoreData.h>
#import <SHModels/ZoneInfoDictionary.h>
#import <SHModels/MonsterInfoDictionary.h>
#import <SHCommon/P_ResourceUtility.h>
#import <SHCommon/ResourceUtility.h>
#import "TestHelpers.h"
#import "TestGlobals.h"
#import "TestDummy.h"



@interface FrequentCase : XCTestCase
@property (strong,nonatomic) ZoneInfoDictionary *zoneInfoDict;
@property (strong,nonatomic) MonsterInfoDictionary *monsterInfoDict;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtil;
@property (strong,nonatomic) SHCoreData* dc;
-(void)resetDb;

-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context;

@end
