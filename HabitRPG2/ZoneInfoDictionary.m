//
//  ZoneInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneInfoDictionary.h"
#import "BundleHelper.h"

@interface ZoneInfoDictionary()
@property (nonatomic,strong) NSDictionary *treeDict;
@property (nonatomic,strong) NSMutableDictionary *flatDict;
@end

@implementation ZoneInfoDictionary

@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:@"ZoneInfo" ofType:@"plist"];
        NSAssert(filePath,@"file path for ZoneInfo was null or empty");
        _treeDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
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
