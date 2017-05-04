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
#import "SingletonCluster.h"

@interface Zone()
@property (nonatomic,weak) ZoneInfoDictionary *zoneInfoDict;
@end

@implementation Zone

@synthesize zoneInfoDict = _zoneInfoDict;
-(ZoneInfoDictionary *)zoneInfoDict{
    if(!_zoneInfoDict){
        _zoneInfoDict = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    }
    return _zoneInfoDict;
}

-(NSString *)fullName{
    NSString* name = [self.zoneInfoDict getZoneName:self.zoneKey];
    return [NSString stringWithFormat:@"%@ %@",name,self.suffix];
}

-(NSString *)synopsis{
    return [self.zoneInfoDict getZoneDescription:self.zoneKey];
}

-(NSString *)headline{
    return @"";
}

@end
