//
//  ZoneHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CoreData.h"
#import "Zone+CoreDataClass.h"

extern NSString* const HOME_KEY;

@interface ZoneHelper : NSObject
    +(NSArray*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl;
    +(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl;
    +(NSString*)getSymbolSuffix:(NSUInteger)visitCount;
    +(NSArray*)getSymbolsList;
    +(Zone * )constructEmptyZone;
    +(Zone *)constructHomeZone;
    +(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
    +(NSArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
    +(Zone *)getZoneByZoneKey:(NSString *)zoneKey;
    +(Zone *)getZone:(BOOL)isFront;
    +(int64_t)getNextUniqueId;
@end
