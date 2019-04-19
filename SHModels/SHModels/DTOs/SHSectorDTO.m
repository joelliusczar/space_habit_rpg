//
//  SHZoneDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHSectorDTO.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHSectorDTO


+(instancetype)newWithZoneDict:(SHSectorInfoDictionary*)zoneInfoDict{
  SHSectorDTO *instance = [SHSectorDTO new];
  instance.zoneInfoDict = zoneInfoDict;
  return instance;
}


-(NSString *)fullName{
    NSString* name = [self.zoneInfoDict getSectorName:self.sectorKey];
    return self.suffix.length?[NSString stringWithFormat:@"%@ %@",name,self.suffix]:name;
}

-(NSString *)synopsis{
    return [self.zoneInfoDict getSectorDescription:self.sectorKey];
}

-(NSString *)headline{
    return @"";
}


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
}

@end
