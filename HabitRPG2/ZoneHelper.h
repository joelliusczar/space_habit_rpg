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


@interface ZoneHelper : NSObject
+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl;
+(NSString*)generateFullZoneNameSuffix:(NSUInteger)visitCount;
+(NSArray*)getSymbols;
+(NSString*)getSymbolSuffix:(NSUInteger)visitCount;
+(NSArray*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl;
+ (NSArray<Zone *> *)setupForAndGetZoneChoices;
+(Zone *)constructHomeZone;
+(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
+(NSArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
+(Zone *)getZoneByZoneKey:(NSString *)zoneKey;
+(Zone *)getZone:(BOOL)isFront;
+(Zone * )constructEmptyZone;
+(int64_t)getNextUniqueId;
@end
