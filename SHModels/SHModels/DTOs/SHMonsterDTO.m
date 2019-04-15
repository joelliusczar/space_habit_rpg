//
//  MonsterDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonsterDTO.h"
#import <SHCommon/NSObject+Helper.h>

static float MAX_HP_MODIFIER = .1;
@implementation MonsterDTO


+(instancetype)newWithMonsterDict:(MonsterInfoDictionary*)monInfoDict{
  MonsterDTO *instance = [MonsterDTO new];
  instance.monInfoDict = monInfoDict;
  return instance;
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

#warning TODO: figure out a better way to handle this
-(int32_t)defense{
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


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
}

@end
