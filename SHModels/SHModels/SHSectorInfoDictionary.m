//
//  SHSectorInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorInfoDictionary.h"
#import <SHCommon/SHSingletonCluster.h>


@interface SHSectorInfoDictionary()
@end

@implementation SHSectorInfoDictionary

@synthesize infoDict = _infoDict;
-(SHInfoDictionary*)infoDict{
  if(nil == _infoDict){
    _infoDict = [[SHInfoDictionary alloc] initWithPListKey:@"ZoneInfo"
      AndBundleClass:SHSectorInfoDictionary.class AndResourceUtil:self.resourceUtil];
  }
  return _infoDict;
}


+(instancetype)newWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
  SHSectorInfoDictionary *instance = [SHSectorInfoDictionary new];
  instance.resourceUtil = resourceUtil;
  return instance;
}

-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
    return [self.infoDict getGroupKeyList:key];
}


-(NSDictionary *)getSectorInfo:(NSString *)sectorKey{
    return [self.infoDict getInfo:sectorKey];
}

-(NSString *)getSectorName:(NSString *)sectorKey{
    return [self getSectorInfo:sectorKey][@"Name"];
}

-(NSString *)getSectorDescription:(NSString *)sectorKey{
    return [self getSectorInfo:sectorKey][@"Description"];
}

@end
