//
//  ZoneHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneHelper.h"
#include "stdlib.h"
#include "SingletonCluster.h"
#import "CommonUtilities.h"
#import "Suffix+CoreDataClass.h"
#import "P_ResourceUtility.h"

NSString* const HOME_KEY = @"HOME";

@implementation ZoneHelper

/*
 We're adding the zone groups to a list and one of them will be randomly selected
 */
+(NSArray<NSString *>*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl{
    if(heroLvl == 0){
        return @[LVL_0_ZONES];
    }
    NSMutableArray<NSString *> *availableZoneGroups  = [[NSMutableArray alloc]init];
    [availableZoneGroups addObject:LVL_1_ZONES];
    if(heroLvl >= 5){
        [availableZoneGroups addObject:LVL_5_ZONES];
        if(heroLvl >= 10){
            [availableZoneGroups addObject:LVL_10_ZONES];
            if(heroLvl >= 15){
                [availableZoneGroups addObject:LVL_15_ZONES];
                if(heroLvl >= 20){
                    [availableZoneGroups addObject:LVL_20_ZONES];
                    if(heroLvl >= 25){
                        [availableZoneGroups addObject:LVL_25_ZONES];
                        if(heroLvl >= 30){
                            [availableZoneGroups addObject:LVL_30_ZONES];
                        }
                    }
                }
            }
        }
    }
    return [NSArray arrayWithArray:availableZoneGroups];
}

+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl{
    NSArray<NSString *> *groupKeys = [ZoneHelper getUnlockedZoneGroupKeys: heroLvl];
    uint r = [CommonUtilities randomUInt:(uint)groupKeys.count];
    NSString *groupKey = groupKeys[r];
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    NSArray *zoneList = [zd getGroupKeyList:groupKey];
    r = [CommonUtilities randomUInt:(uint32_t)zoneList.count];
    return zoneList[r];
}

+(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
    NSMutableArray<NSString *> *suffixList = [NSMutableArray array];
    NSArray *symbols = [ZoneHelper getSymbolsList];
    while(visitCount > 0){
        NSUInteger m = (visitCount-1) % symbols.count;
        visitCount -= m;
        visitCount /= symbols.count;
        [suffixList addObject:symbols[m]];
    }
    return [[[suffixList reverseObjectEnumerator] allObjects] componentsJoinedByString:@" "];
}

+(NSArray *)getSymbolsList{
    NSArray *symbols = [[SingletonCluster getSharedInstance]
                .resourceUtility getPListArray:@"SuffixList" withClassBundle:NSClassFromString(@"ZoneHelper")];
    
    return symbols;
}

+(Zone *)constructEmptyZone{
    return [[Zone alloc] initWithEntity:Zone.entity insertIntoManagedObjectContext:nil];
}

+(Zone *)constructHomeZone{
    Zone *z = [ZoneHelper constructEmptyZone];
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffix = @"";
    z.isFront = YES;
    return z;
}

+(Zone *)constructZoneChoice:(nonnull Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = [ZoneHelper constructEmptyZone];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl];
    z.zoneKey = zoneKey;
    z.suffix = [ZoneHelper getSymbolSuffix:[ZoneHelper getVisitCountForZone:zoneKey]];
    z.maxMonsters = [CommonUtilities randomUInt:MAX_MONSTER_RAND_UP_BOUND]  + MAX_MONSTER_LOW_BOUND;
    z.monstersKilled = 0;
    z.lvl = matchLvl?hero.lvl:[CommonUtilities calculateLvl:hero.lvl OffsetBy:ZONE_LVL_RANGE];
    return z;
}

+(NSMutableArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    //Zone create uses nil context so that should be okay
    NSManagedObjectContext *suffixContext = [SHData constructContext:NSMainQueueConcurrencyType];
    SHData.inUseContext = suffixContext;
    uint zoneCount = [CommonUtilities randomUInt:MAX_ZONE_CHOICE_RAND_UP_BOUND]  + MIN_ZONE_CHOICE_COUNT;
    NSMutableArray<Zone *> *choices = [NSMutableArray arrayWithCapacity:zoneCount];
    choices[0] = [self constructZoneChoice:hero AndMatchHeroLvl:matchLvl];
    for(uint i = 1;i<zoneCount;i++){
        choices[i] = [self constructZoneChoice:hero AndMatchHeroLvl:NO];
    }
    SHData.inUseContext = nil;
    return choices;
}


+(int32_t)getVisitCountForZone:(NSString *)zoneKey{
    Suffix *s = [ZoneHelper getSuffixEntity:zoneKey];
    int currentVisitCount = s.visitCount++;
    [SHData save];
    return currentVisitCount;
}

+(Suffix *)getSuffixEntity:(NSString *)zoneKey{
    NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
    NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    NSArray<NSManagedObject *> *results = [SHData getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];
    NSAssert(results.count<2, @"There are too many entities");
    Suffix *s;
    if(results.count){
        s = (Suffix *)results[0];
    }
    else{
        s = (Suffix *)[SHData constructEmptyEntity:SUFFIX_ENTITY_NAME];
        s.zoneKey = zoneKey;
    }
    return s;
}


//deprecated
+(Zone *)getZoneByZoneKey:(NSString *)zoneKey{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    
    NSArray<NSManagedObject *> *results = [[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortBySuffixNumber]];
    NSAssert(results.count<2, @"There are too many zones");
    return (Zone *)results[0];
}

+(Zone *)getZone:(BOOL)isFront{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%d",isFront?1:0];
    NSArray<NSManagedObject *> *results = [ZoneHelper getAllZones:filter];
    NSAssert(results.count<2, @"There are too many zones");
    return (Zone *)results[0];
}

+(NSArray<NSManagedObject *> *)getAllZones:(NSPredicate *)filter{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
    NSArray<NSManagedObject *> *results = [SHData getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];
    return results;
}

+(void)moveZoneToFront:(Zone *)newFront{
    NSArray<NSManagedObject *> *results = [ZoneHelper getAllZones:nil];
    newFront.isFront = YES;
    NSAssert(results.count<3, @"There are too many zones");
    if(results.count==0){
        return;
    }
    if(results.count==1){
        ((Zone *)results[0]).isFront = NO;
        return;
    }
    [SHData softDeleteModel:results[1]];
    ((Zone *)results[0]).isFront = NO;
    
}

@end
