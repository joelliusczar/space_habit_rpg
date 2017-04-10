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

+(NSArray *)getZoneGroup:(NSInteger)key{
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    
    if(key == LVL_5_ZONES){
        return [zd getGroupKeyList:@"LVL_5_ZONES"];
    }
    else if(key == LVL_10_ZONES){
        return [zd getGroupKeyList:@"LVL_10_ZONES"];
    }
    else if(key == LVL_15_ZONES){
        return [zd getGroupKeyList:@"LVL_15_ZONES"];
    }
    else if(key == LVL_20_ZONES){
        return [zd getGroupKeyList:@"LVL_20_ZONES"];
    }
    else if(key == LVL_25_ZONES){
        return [zd getGroupKeyList:@"LVL_25_ZONES"];
    }
    else if(key == LVL_30_ZONES){
        return [zd getGroupKeyList:@"LVL_30_ZONES"];
    }
    else{
        return [zd getGroupKeyList:@"LVL_1_ZONES"];
    }
}

+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl{
    NSArray *groupKeys = [ZoneHelper getUnlockedZoneGroupKeys: heroLvl];
    uint32_t r = [CommonUtilities randomUInt:(uint32_t)groupKeys.count];
    NSInteger groupKey = [((NSNumber*)groupKeys[r]) integerValue];
    NSArray *zoneList = [ZoneHelper getZoneGroup:groupKey];
    r = [CommonUtilities randomUInt:(uint32_t)zoneList.count];
    return zoneList[r];
}



+(NSString*)generateFullZoneNameSuffix:(NSUInteger)visitCount{
    if(visitCount < 1){
        return @"";
    }
    
    NSArray *symbols = [ZoneHelper getSymbols];
    NSUInteger numericSuffix = 0;
    if(visitCount > ((symbols.count -1)*symbols.count)){
        numericSuffix = [ZoneHelper getNumericSuffixForZoneVisit:visitCount LengthOfSymbolsTable:symbols.count];
        visitCount = [ZoneHelper adjustVisitCountForHugeNumbers:visitCount LengthOfSymbolsTable:symbols.count];
    }
    NSUInteger adjustedVisitCount = [ZoneHelper skipPowersOfBaseInNumber:visitCount Base:symbols.count];
    NSMutableString *suffix = [NSMutableString stringWithString:[ZoneHelper getSymbolSuffix:adjustedVisitCount]];
    if(numericSuffix > 0){
        [suffix appendString:[NSString stringWithFormat:@"%lu",numericSuffix]];
    }
    return [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
    NSMutableString *suffix = [NSMutableString string];
    NSArray *symbols = [ZoneHelper getSymbols];
    while(visitCount > 0){
        NSUInteger symbolIndex = visitCount % symbols.count;
        visitCount /= symbols.count;
        [suffix appendFormat:@"%@ ",[symbols objectAtIndex:symbolIndex]];
    }
    return [suffix stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
}

+(NSUInteger)adjustVisitCountForHugeNumbers:(NSUInteger)visitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    return visitCount % ((symbolsLen -1 )*symbolsLen);
}

+(NSArray *)getSymbols{
    NSArray *symbols = [[SingletonCluster getSharedInstance]
                .resourceUtility getPListArray:@"SuffixList" withClassBundle:NSClassFromString(@"ZoneHelper")];
    
    return symbols;
}

+(NSUInteger)skipPowersOfBaseInNumber:(NSUInteger)num Base:(NSUInteger)base{
    /*
     Numbers naturally want to follow this pattern:
     0,A,B,C,...,Y,Z,A0,AA,AB,AC,...,AY,AZ,B0,BA,BB,BC
     But I want zone suffix naming system to follow this pattern:
     0,A,B,C,...,Y,Z,AA,AB,AC,...,AY,AZ,BA,BB,BC,...
     This function adjust numbers to fit the wanted pattern,
     i.e. without the proverbial mulitples of 10
     The accuracy of this function becomes unreliable after base^2

     */
    NSUInteger adjusterNum = num + (num/base);
    return num + (adjusterNum / base);
}

+(NSUInteger)getNumericSuffixForZoneVisit:(NSUInteger)zoneVisitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    //#the -1 on the first array length is to account for the single symbol range of items
    return zoneVisitCount / ((symbolsLen-1) * symbolsLen) + 1; //#+1 because the 1 suffix would be redundant
}
/*
    We're adding the zone groups to a list and one of them will be randomly selected
 */
+(NSArray*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl{
    NSMutableArray *availableZoneGroups  = [[NSMutableArray alloc]init];
    [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_1_ZONES] ];
    if(heroLvl >= 5){
        [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_5_ZONES] ];
        if(heroLvl >= 10){
            [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_10_ZONES] ];
            if(heroLvl >= 15){
                [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_15_ZONES] ];
                if(heroLvl >= 20){
                    [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_20_ZONES] ];
                    if(heroLvl >= 25){
                        [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_25_ZONES] ];
                        if(heroLvl >= 30){
                            [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_30_ZONES] ];
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
