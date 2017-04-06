//
//  Monster+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"
#import "SingletonCluster.h"
#import "MonsterInfoDictionary.h"

@interface Monster()
@property (nonatomic,weak) MonsterInfoDictionary *monInfoDict;
@end

@implementation Monster

    @synthesize monInfoDict = _monInfoDict;
    -(MonsterInfoDictionary *)monInfoDict{
        if(!_monInfoDict){
            _monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
        }
        return _monInfoDict;
    }
    
    -(NSString *)fullName{
        return [self.monInfoDict getName:self.monsterKey];
    }
    
    -(NSString *)synopsis{
        return [self.monInfoDict getDescription:self.monsterKey];
    }
    
    -(int32_t)attack{
        return [self.monInfoDict getBaseAttack:self.monsterKey] + self.lvl;
    }
    
    -(int32_t)defense{//todo: figure out a better way to handle this
        return [self.monInfoDict getBaseDefense:self.monsterKey];
    }
    
    -(int32_t)xp{
        return [self.monInfoDict getBaseXP:self.monsterKey] + self.lvl;
    }
    
    -(int32_t)hp{
        return [self.monInfoDict getBaseHP:self.monsterKey];
    }
    
    -(float)treasureDropRate{
        return [self.monInfoDict getTreasureDropRate:self.monsterKey];
    }
    
    -(int32_t)encounterWeight{
        return [self.monInfoDict getEncounterWeight:self.monsterKey];
    }

@end
