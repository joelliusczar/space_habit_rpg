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
#import <SHModels/SHSectorInfoDictionary.h>
#import <SHModels/SHMonsterInfoDictionary.h>
#import <SHCommon/SHResourceUtilityProtocol.h>
#import <SHCommon/SHResourceUtility.h>
#import "TestHelpers.h"
#import "TestGlobals.h"
#import "TestDummy.h"



@interface FrequentCase : XCTestCase
@property (strong,nonatomic) SHSectorInfoDictionary *zoneInfoDict;
@property (strong,nonatomic) SHMonsterInfoDictionary *monsterInfoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) SHCoreData* dc;
-(void)resetDb;

-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
context:(NSManagedObjectContext*)context;

@end
