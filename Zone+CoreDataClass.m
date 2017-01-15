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

//-(BOOL)isCurrentZone_H{
//    return self.isCurrentZone.boolValue;
//}
//
//-(void)setIsCurrentZone_H:(BOOL)isCurrentZone_H{
//    self.isCurrentZone = [NSNumber numberWithBool:isCurrentZone_H];
//}
//
//-(int32_t)lvl_H{
//    return self.lvl.intValue;
//}
//
//-(void)setLvl_H:(int32_t)lvl_H{
//    self.lvl = [NSNumber numberWithInt:lvl_H];
//}
//
//-(int32_t)maxMonsters_H{
//    return self.maxMonsters.intValue;
//}
//
//-(void)setMaxMonsters_H:(int32_t)maxMonsters_H{
//    self.maxMonsters = [NSNumber numberWithInt:maxMonsters_H];
//}
//
//-(int32_t)monstersKilled_H{
//    return self.monstersKilled.intValue;
//}
//
//-(void)setMonstersKilled_H:(int32_t)monstersKilled_H{
//    self.monstersKilled = [NSNumber numberWithInt:monstersKilled_H];
//}
//
//-(int32_t)previousZonePK_H{
//    return self.previousZonePK.intValue;
//}
//
//-(void)setPreviousZonePK_H:(int32_t)previousZonePK_H{
//    self.previousZonePK = [NSNumber numberWithInt:previousZonePK_H];
//}
//
//-(int32_t)suffixNumber_H{
//    return self.suffixNumber.intValue;
//}
//
//-(void)setSuffixNumber_H:(int32_t)suffixNumber_H{
//    self.suffixNumber = [NSNumber numberWithInt:suffixNumber_H];
//}
//
//-(int64_t)uniqueId_H{
//    return self.uniqueId.intValue;
//}
//
//-(void)setUniqueId_H:(int64_t)uniqueId_H{
//    self.uniqueId = [NSNumber numberWithLong:uniqueId_H];
//}
//
@end
