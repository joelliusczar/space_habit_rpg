//
//  MonsterHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Monster+CoreDataClass.h"
#import <SHCommon/ProbWeight.h>

@interface Monster (Helper)
Monster* constructRandomMonster(NSString* zoneKey,uint32_t zoneLvl);
NSString* randomMonsterKey(NSString* zoneKey);
Monster* constructEmptyMonster(void);
ProbWeight* buildProbilityWeight(NSMutableArray<NSString*>* keys);
Monster* getCurrentMonster(void);
@end
