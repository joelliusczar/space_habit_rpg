//
//  SHFrequentCase.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//


#import <XCTest/XCTest.h>
#import <objc/runtime.h>

@import SHModels;
@import SHCommon;



@interface SHFrequentCase : XCTestCase
@property (strong,nonatomic) SHSectorInfoDictionary *sectorInfoDict;
@property (strong,nonatomic) SHMonsterInfoDictionary *monsterInfoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) SHCoreData* dc;
-(void)resetDb;

-(NSArray<NSManagedObject*> *)fetchAnything:(NSFetchRequest *)request
	context:(NSManagedObjectContext*)context;

@end

