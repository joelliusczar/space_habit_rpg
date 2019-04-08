//
//  SHZoneDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHZoneDTO.h"

@implementation ZoneDTO


+(instancetype)newWithZoneDict:(ZoneInfoDictionary*)zoneInfoDict{
  ZoneDTO *instance = [ZoneDTO new];
  instance.zoneInfoDict = zoneInfoDict;
  return instance;
}


-(NSString *)fullName{
    NSString* name = [self.zoneInfoDict getZoneName:self.zoneKey];
    return self.suffix.length?[NSString stringWithFormat:@"%@ %@",name,self.suffix]:name;
}

-(NSString *)synopsis{
    return [self.zoneInfoDict getZoneDescription:self.zoneKey];
}

-(NSString *)headline{
    return @"";
}


@end
