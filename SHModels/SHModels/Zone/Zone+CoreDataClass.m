//
//  Zone+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"
#import "ZoneInfoDictionary.h"
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/NSMutableDictionary+Helper.h>

@interface Zone()
@property (nonatomic,weak) ZoneInfoDictionary *zoneInfoDict;
@end

@implementation Zone

@synthesize zoneInfoDict = _zoneInfoDict;
-(ZoneInfoDictionary *)zoneInfoDict{
    if(!_zoneInfoDict){
        _zoneInfoDict = [SharedGlobal.bag getWithKey:@"zoneDict"
        OrCreateFromBlock:^id(){
            return [ZoneInfoDictionary new];
        }];
    }
    return _zoneInfoDict;
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

-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.fullName,@"fullName"
            ,self.zoneKey,@"zoneKey"
            ,self.suffix,@"suffix"
            ,[NSNumber numberWithInt:self.lvl],@"lvl"
            ,[NSNumber numberWithInt:self.maxMonsters],@"maxMonsters"
            ,[NSNumber numberWithInt:self.monstersKilled],@"monstersKilled"
            ,[NSNumber numberWithLong:self.uniqueId],@"uniqueId"
            ,[NSNumber numberWithBool:self.isFront],@"isFront", nil];
}


@end
