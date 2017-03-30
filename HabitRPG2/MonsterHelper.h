//
//  MonsterHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Monster+CoreDataClass.h"

@interface MonsterHelper : NSObject
+(Monster *)constructRandomMonster:(NSString *)zoneKey AroundLvl:(uint32_t)zoneLvl;
+(Monster *)constructEmptyMonster;
@end
