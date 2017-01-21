//
//  Zone+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"
#import "ZoneHelper.h"
#import "ZoneInfoDictionary.h"

@interface Zone()
@property (nonatomic,strong) ZoneInfoDictionary *zoneInfoDict;
@end

@implementation Zone

@synthesize zoneInfoDict = _zoneInfoDict;
-(ZoneInfoDictionary *)zoneInfoDict{
    if(!_zoneInfoDict){
        _zoneInfoDict = [ZoneInfoDictionary construct];
    }
    return _zoneInfoDict;
}

-(NSString *)fullName{
    NSString* name = [self.zoneInfoDict getZoneName:self.zoneKey];
    NSString* suffix = [ZoneHelper getSymbolSuffix:self.suffixNumber];
    return [NSString stringWithFormat:@"%@ %@",name,suffix];
}

-(NSString *)synopsis{
    return [self.zoneInfoDict getZoneDescription:self.zoneKey];
}

@end
