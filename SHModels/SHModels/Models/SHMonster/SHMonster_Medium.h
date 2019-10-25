//
//	SHMonster_Medium.h
//	SHModels
//
//	Created by Joel Pridgen on 3/25/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonsterInfoDictionary.h"
#import "SHMonster.h"
@import Foundation;
@import SHCommon;
@import SHData;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHMonster_Medium : NSObject
-(instancetype)initWithContext:(NSManagedObjectContext*)context;

-(SHMonster*)newRandomMonster:(NSString*)sectorKey sectorLvl:(uint32_t)sectorLvl;
-(NSString*)randomMonsterKey:(NSString*)sectorKey;
-(SHProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys;
-(SHMonster*)currentMonster;
@end

NS_ASSUME_NONNULL_END
