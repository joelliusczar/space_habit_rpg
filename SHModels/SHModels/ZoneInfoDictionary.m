//
//  ZoneInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneInfoDictionary.h"
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/P_ResourceUtility.h>

@interface ZoneInfoDictionary()
@end

@implementation ZoneInfoDictionary


+(instancetype)new{
    ZoneInfoDictionary *instance = [[ZoneInfoDictionary alloc] initWithPListKey:@"ZoneInfo"];
    instance.bundleClass = instance.class;
    return instance;
}

-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    NSDictionary *group = self.treeDict[key];
    return group.allKeys;
}

-(NSDictionary *)searchZoneGroupsForZone:(NSString *)zoneKey{
    NSEnumerator<NSString*> *enumerator = [self.treeDict keyEnumerator];
    NSString *nextKey;
    while(nextKey = [enumerator nextObject]){
        if(self.treeDict[nextKey][zoneKey]){
            return self.treeDict[nextKey][zoneKey];
        }
    }
    return nil;
}

-(NSDictionary *)getZoneInfo:(NSString *)zoneKey{
    NSDictionary *zoneInfo;
    if(!(zoneInfo = [self.flatDict valueForKey:zoneKey])){
        zoneInfo = [self searchZoneGroupsForZone:zoneKey];
        if(zoneInfo){
            self.flatDict[zoneKey] = zoneInfo;
        }
    }
    return zoneInfo;
}

-(NSString *)getZoneName:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Name"];
}

-(NSString *)getZoneDescription:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Description"];
}

@end
