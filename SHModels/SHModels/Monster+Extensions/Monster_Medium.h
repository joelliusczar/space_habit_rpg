//
//  Monster_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/ProbWeight.h>
#import <SHData/P_CoreData.h>
#import "MonsterInfoDictionary.h"
#import "Monster+CoreDataClass.h"

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface Monster_Medium : NSObject
+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
withInfoDict:(MonsterInfoDictionary*)monsterInfo;
-(Monster*)newRandomMonster:(NSString*)zoneKey zoneLvl:(uint32_t)zoneLvl;
-(NSString*)randomMonsterKey:(NSString*)zoneKey;
-(Monster*)newEmptyMonster;
-(ProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys;
-(Monster*)getCurrentMonster;
-(Monster*)getCurrentMonsterWithContext:(nullable NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
