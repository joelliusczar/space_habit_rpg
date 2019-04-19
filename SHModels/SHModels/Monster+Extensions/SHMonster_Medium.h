//
//  Monster_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHProbWeight.h>
#import <SHData/SHCoreDataProtocol.h>
#import "SHMonsterInfoDictionary.h"
#import "SHMonster+CoreDataClass.h"
#import "SHMonsterDTO.h"

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface Monster_Medium : NSObject
+(instancetype)newWithContext:(NSManagedObjectContext*)context
  withInfoDict:(SHMonsterInfoDictionary*)monsterInfo;

-(SHMonsterDTO*)newRandomMonster:(NSString*)sectorKey zoneLvl:(uint32_t)zoneLvl;
-(NSString*)randomMonsterKey:(NSString*)sectorKey;
-(SHMonsterDTO*)newEmptyMonster;
-(SHProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys;
-(SHMonster*)getCurrentMonster;
@end

NS_ASSUME_NONNULL_END
