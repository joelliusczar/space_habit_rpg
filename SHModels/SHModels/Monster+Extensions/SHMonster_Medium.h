//
//  Monster_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHProbWeight.h>
#import <SHData/P_SHCoreData.h>
#import "SHMonsterInfoDictionary.h"
#import "SHMonster+CoreDataClass.h"
#import "SHMonsterDTO.h"

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface Monster_Medium : NSObject
+(instancetype)newWithContext:(NSManagedObjectContext*)context
  withInfoDict:(MonsterInfoDictionary*)monsterInfo;

-(MonsterDTO*)newRandomMonster:(NSString*)zoneKey zoneLvl:(uint32_t)zoneLvl;
-(NSString*)randomMonsterKey:(NSString*)zoneKey;
-(MonsterDTO*)newEmptyMonster;
-(ProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys;
-(Monster*)getCurrentMonster;
@end

NS_ASSUME_NONNULL_END
