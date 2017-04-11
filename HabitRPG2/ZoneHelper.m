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


+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl{
    NSArray<NSString *> *groupKeys = [ZoneHelper getUnlockedZoneGroupKeys: heroLvl];
    uint32_t r = [CommonUtilities randomUInt:(uint32_t)groupKeys.count];
    NSString *groupKey = groupKeys[r];
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    NSArray *zoneList = [zd getGroupKeyList:groupKey];
    r = [CommonUtilities randomUInt:(uint32_t)zoneList.count];
    return zoneList[r];
}



+(NSString*)generateSuffix:(NSUInteger)visitCount{
    if(visitCount < 1){
        return @"";
    }
    NSArray *symbols = [ZoneHelper getSymbols];
    NSUInteger numericSuffix = 0;
    if(visitCount > ((symbols.count -1)*symbols.count)){
        numericSuffix = [ZoneHelper getNumericSuffixForZoneVisit:visitCount LengthOfSymbolsTable:symbols.count];
        visitCount = [ZoneHelper adjustVisitCountForHugeNumbers:visitCount LengthOfSymbolsTable:symbols.count];
    }
    NSMutableString *suffix = [NSMutableString stringWithString:[ZoneHelper getSymbolSuffix:visitCount]];
    if(numericSuffix > 0){
        [suffix appendString:[NSString stringWithFormat:@"%lu",numericSuffix]];
    }
    return [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
    NSMutableArray<NSString *> *suffixList = [NSMutableArray array];
    NSArray *symbols = [ZoneHelper getSymbols];
    while(visitCount > 0){
        NSUInteger m = (visitCount-1) % symbols.count;
        visitCount -= m;
        visitCount /= symbols.count;
        [suffixList addObject:symbols[m]];
    }
    return [suffixList componentsJoinedByString:@" "];
}

+(NSUInteger)adjustVisitCountForHugeNumbers:(NSUInteger)visitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    return visitCount % ((symbolsLen -1 )*symbolsLen);
}

+(NSArray *)getSymbols{
    NSArray *symbols = [[SingletonCluster getSharedInstance]
                .resourceUtility getPListArray:@"SuffixList" withClassBundle:NSClassFromString(@"ZoneHelper")];
    
    return symbols;
}


    //I think this is for really high visit counts
+(NSUInteger)getNumericSuffixForZoneVisit:(NSUInteger)zoneVisitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    //#the -1 on the first array length is to account for the single symbol range of items
    return zoneVisitCount / ((symbolsLen-1) * symbolsLen) + 1; //#+1 because the 1 suffix would be redundant
}
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

+(NSArray<Zone *> *)setupForAndGetZoneChoices{
    NSObject<P_CoreData> *dataController = [SingletonCluster getSharedInstance].dataController;
    Hero *hero = dataController.userData.theHero;
    NSArray<Zone *> *zoneChoices = [ZoneHelper constructMultipleZoneChoices:hero AndMatchHeroLvl:YES];
    return zoneChoices;
}

+(Zone *)constructHomeZone{
    Zone *z = [ZoneHelper constructEmptyZone];
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffix = @"";
    z.uniqueId = [self getNextUniqueId];
    z.isFront = YES;
    [[SingletonCluster getSharedInstance].dataController save];
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

+(NSArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    u_int32_t zoneCount = [CommonUtilities randomUInt:MAX_ZONE_CHOICE_RAND_UP_BOUND]  + MIN_ZONE_CHOICE_COUNT;
    NSMutableArray<Zone *> *choices = [NSMutableArray arrayWithCapacity:zoneCount];
    choices[0] = [self constructZoneChoice:hero AndMatchHeroLvl:matchLvl];
    for(u_int32_t i = 1;i<zoneCount;i++){
        choices[i] = [self constructZoneChoice:hero AndMatchHeroLvl:NO];
    }
    
    return [NSArray arrayWithArray:choices];
}

+(int32_t)getVisitCountForZone:(NSString *)zoneKey{
    Suffix *s = [ZoneHelper getSuffix:zoneKey];
    return s.visitCount+1;
}

+(Suffix *)getSuffix:(NSString *)zoneKey{
    NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
    NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    return (Suffix *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];
}

//I think this may be unneeded. But I'll leave it alone for now.
//I think it is a relic of the graph way of storing previous zones.
+(Zone *)getZoneByZoneKey:(NSString *)zoneKey{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    
    return (Zone *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortBySuffixNumber]];
}

+(Zone *)constructEmptyZone{
    return (Zone *)[[SingletonCluster getSharedInstance].dataController constructEmptyEntity:ZONE_ENTITY_NAME];
}

+(Zone *)getZone:(BOOL)isFront{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:YES];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%@",isFront];
    return (Zone *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];
}

+(int64_t)getNextUniqueId{
    int64_t nextId = [SingletonCluster getSharedInstance].dataController.userData.theDataInfo.nextZoneId;
    [SingletonCluster getSharedInstance].dataController.userData.theDataInfo.nextZoneId++;
    [[SingletonCluster getSharedInstance].dataController save];
    return nextId;
}

@end
