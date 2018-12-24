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

@synthesize zoneInfoDict = _zoneInfoDict;
-(InfoDictionary*)zoneInfoDict{
  if(nil == _zoneInfoDict){
    _zoneInfoDict = [[InfoDictionary alloc] initWithPListKey:@"ZoneInfo"
      AndBundleClass:ZoneInfoDictionary.class];
  }
  return _zoneInfoDict;
}


-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    return [self.zoneInfoDict getGroupKeyList:key];
}


-(NSDictionary *)getZoneInfo:(NSString *)zoneKey{
    return [self.zoneInfoDict getInfo:zoneKey];
}

-(NSString *)getZoneName:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Name"];
}

-(NSString *)getZoneDescription:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Description"];
}

@end
