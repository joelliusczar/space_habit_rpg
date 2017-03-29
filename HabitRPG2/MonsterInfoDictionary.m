//
//  MonsterInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterInfoDictionary.h"
#import "CommonUtilities.h"

@interface MonsterInfoDictionary()
@property (nonatomic,strong) NSDictionary *treeDict;
@property (nonatomic,strong) NSMutableDictionary *flatDict;
@end

@implementation MonsterInfoDictionary

@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        CommonUtilities *util = [[CommonUtilities alloc] init];
        _treeDict = [util getPListDict:@"zoneInfo" withClassBundle:self.class];
    }
    return _treeDict;
}

@synthesize flatDict = _flatDict;
-(NSMutableDictionary *)flatDict{
    if(!_flatDict){
        _flatDict = [NSMutableDictionary dictionary];
    }
    return _flatDict;
}

+(instancetype)construct{
    MonsterInfoDictionary *instance = [[MonsterInfoDictionary alloc]init];
    return instance;
}

-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    NSDictionary *group = self.treeDict[key];
    return group.allKeys;
}

-(NSDictionary *)searchZonesForMonster:(NSString *)monsterKey{
    NSEnumerator<NSString*> *enumerator = [self.treeDict keyEnumerator];
    NSString *nextKey;
    while(nextKey = [enumerator nextObject]){
        if(self.treeDict[nextKey][monsterKey]){
            return self.treeDict[nextKey][monsterKey];
        }
    }
    return nil;
}

-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForZone:(NSString *)zoneKey{
    if(self.treeDict[zoneKey][monsterKey]){
        NSDictionary *monsterInfo = self.treeDict[zoneKey][monsterKey];
        if(!self.flatDict[zoneKey]){
            self.flatDict[zoneKey] = monsterInfo;
        }
        return monsterInfo;
    }
    return nil;
}

-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey{
    NSDictionary *monsterInfo;
    if(!(monsterInfo = [self.flatDict valueForKey:monsterKey])){
        monsterInfo = [self searchZonesForMonster:monsterKey];
        if(monsterInfo){
            self.flatDict[monsterKey] = monsterInfo;
        }
    }
    return monsterInfo;
}

@end
