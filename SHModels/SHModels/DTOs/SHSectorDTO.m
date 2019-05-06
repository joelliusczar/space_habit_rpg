//
//  SHSectorDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHSectorDTO.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHSectorDTO


+(instancetype)newWithSectorDict:(SHSectorInfoDictionary*)sectorInfoDict{
  SHSectorDTO *instance = [SHSectorDTO new];
  instance.sectorInfoDict = sectorInfoDict;
  return instance;
}

-(void)setValue:(id)value forKey:(NSString *)key{
  if([key isEqualToString:@"_sectorInfoDict"] && nil == value) return;
  [super setValue:value forKey:key];
}


-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.fullName,@"fullName"
            ,self.sectorKey,@"sectorKey"
            ,self.suffix,@"suffix"
            ,[NSNumber numberWithInt:self.lvl],@"lvl"
            ,[NSNumber numberWithInt:self.maxMonsters],@"maxMonsters"
            ,[NSNumber numberWithInt:self.monstersKilled],@"monstersKilled"
            ,[NSNumber numberWithLong:self.uniqueId],@"uniqueId"
            ,[NSNumber numberWithBool:self.isFront],@"isFront", nil];
}


-(NSString *)fullName{
    NSString* name = [self.sectorInfoDict getSectorName:self.sectorKey];
    return self.suffix.length?[NSString stringWithFormat:@"%@ %@",name,self.suffix]:name;
}

-(NSString *)synopsis{
    return [self.sectorInfoDict getSectorDescription:self.sectorKey];
}

-(NSString *)headline{
    return @"";
}


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
}

@end
