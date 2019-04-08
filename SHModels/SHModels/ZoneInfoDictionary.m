//
//  ZoneInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneInfoDictionary.h"
#import <SHCommon/SingletonCluster.h>


@interface ZoneInfoDictionary()
@end

@implementation ZoneInfoDictionary

@synthesize infoDict = _infoDict;
-(InfoDictionary*)infoDict{
  if(nil == _infoDict){
    _infoDict = [[InfoDictionary alloc] initWithPListKey:@"ZoneInfo"
      AndBundleClass:ZoneInfoDictionary.class AndResourceUtil:self.resourceUtil];
  }
  return _infoDict;
}


+(instancetype)newWithResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil{
  ZoneInfoDictionary *instance = [ZoneInfoDictionary new];
  instance.resourceUtil = resourceUtil;
  return instance;
}

-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    return [self.infoDict getGroupKeyList:key];
}


-(NSDictionary *)getZoneInfo:(NSString *)zoneKey{
    return [self.infoDict getInfo:zoneKey];
}

-(NSString *)getZoneName:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Name"];
}

-(NSString *)getZoneDescription:(NSString *)zoneKey{
    return [self getZoneInfo:zoneKey][@"Description"];
}

@end
