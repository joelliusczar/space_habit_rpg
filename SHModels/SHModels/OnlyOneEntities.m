//
//  OnlyOneEntities.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "OnlyOneEntities.h"
#import <SHGlobal/Constants.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHCommon/SingletonCluster.h>


@interface OnlyOneEntities()
@property (nonatomic,weak)  NSObject<P_CoreData> *dataController;
@end

@implementation OnlyOneEntities




-(Hero *)constructHeroInitialState{
    Hero *hero = (Hero *)[self.dataController.mainThreadContext newEntity:Hero.entity];
    hero.gold = 0;
    hero.lvl = 1;
    hero.maxHp = 50;
    hero.maxXp = 100;
    hero.nowHp = 50;
    hero.nowXp = 0;
    hero.shipName = @"";
    return hero;
}
@end
