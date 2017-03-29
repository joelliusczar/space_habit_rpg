//
//  MonsterMaker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CoreData.h"
#import "Monster+CoreDataClass.h"

@interface MonsterMaker : NSObject
+(instancetype)constructWithDataController:(NSObject<P_CoreData> *)dataController;
-(instancetype)initWithDataController:(NSObject<P_CoreData> *)dataController;
-(Monster *)constructRandomMonster:(NSString *)zoneKey AroundLvl:(uint32_t)zoneLvl;
-(Monster *)constructEmptyMonster;
@end
