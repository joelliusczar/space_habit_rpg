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

float MAX_HP_MODIFIER = .1;
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

-(NSString *)headline{
    NSString *grammaticalAgreement = [self.monInfoDict getGrammaticalAgreement:self.monsterKey];
    if([grammaticalAgreement isEqualToString:@"SC"]){
        return [NSString stringWithFormat:@"Your ship encountered a \n%@!",self.fullName];
    }
    if([grammaticalAgreement isEqualToString:@"SV"]){
        return [NSString stringWithFormat:@"Your ship encountered an \n%@!",self.fullName];
    }
    if([grammaticalAgreement isEqualToString:@"PL"]){
        return [NSString stringWithFormat:@"Your ship encountered some \n%@!",self.fullName];
    }
    @throw [NSException exceptionWithName:@"Invalid gramatical agreement" reason:[NSString stringWithFormat:@"The culprit was %@",self.fullName]userInfo:nil];
}

-(int32_t)attack{
    return [self.monInfoDict getBaseAttack:self.monsterKey] + self.lvl;
}

-(int32_t)defense{//TODO: figure out a better way to handle this
    return [self.monInfoDict getBaseDefense:self.monsterKey];
}

-(int32_t)xp{
    return [self.monInfoDict getBaseXP:self.monsterKey];
}

-(int32_t)maxHp{
    int baseHp = [self.monInfoDict getBaseHP:self.monsterKey];
    return baseHp + (self.lvl*baseHp*MAX_HP_MODIFIER);
}

-(float)treasureDropRate{
    return [self.monInfoDict getTreasureDropRate:self.monsterKey];
}

-(int32_t)encounterWeight{
    return [self.monInfoDict getEncounterWeight:self.monsterKey];
}

-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.monsterKey,@"monsterKey"
            ,[NSNumber numberWithInt:self.lvl],@"lvl"
            ,[NSNumber numberWithInt:self.nowHp],@"nowHp"
            ,[NSNumber numberWithInt:self.attack],@"attack"
            ,[NSNumber numberWithInt:self.defense],@"defense"
            ,[NSNumber numberWithInt:self.maxHp],@"maxHp"
            , nil];
}

@end
