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
@property (nonatomic,strong) NSDictionary *treeDict;
@property (nonatomic,strong) NSMutableDictionary *flatDict;
@end

@implementation ZoneInfoDictionary

@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        NSObject<P_ResourceUtility> *ru = SharedGlobal.resourceUtility;
        NSBundle *bundle = [NSBundle bundleForClass:self.class];
        _treeDict = [ru getPListDict:@"ZoneInfo" withBundle:bundle];
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

+(instancetype)new{
    ZoneInfoDictionary *instance = [[ZoneInfoDictionary alloc]init];
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
