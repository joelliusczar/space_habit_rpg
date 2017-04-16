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
        uint32_t r = [CommonUtilities randomUInt:(uint32_t)groupKeys.count];
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
        return (Zone *)[[SingletonCluster getSharedInstance].dataController constructEmptyEntity:ZONE_ENTITY_NAME];
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
        [[SingletonCluster getSharedInstance].dataController save:z];
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
        Suffix *s = [ZoneHelper getSuffixEntity:zoneKey];
        int currentVisitCount = s.visitCount++;
        [[SingletonCluster getSharedInstance].dataController save:s];
        return currentVisitCount;
    }

    +(Suffix *)getSuffixEntity:(NSString *)zoneKey{
        NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
        NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
        Suffix *s = (Suffix *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];
        if(!s){
            s = (Suffix *)[[SingletonCluster getSharedInstance].dataController constructEmptyEntity:SUFFIX_ENTITY_NAME];
            s.zoneKey = zoneKey;
        }
        return s;
    }
    

    //deprecated
    +(Zone *)getZoneByZoneKey:(NSString *)zoneKey{
        NSFetchRequest<Zone *> *request = [Zone fetchRequest];
        NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
        
        return (Zone *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortBySuffixNumber]];
    }

    +(Zone *)getZone:(BOOL)isFront{
        NSFetchRequest<Zone *> *request = [Zone fetchRequest];
        NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:YES];
        NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%@",isFront];
        return (Zone *)[[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];
    }

    +(int64_t)getNextUniqueId{
        DataInfo *di = [SingletonCluster getSharedInstance].dataController.userData.theDataInfo;
        int64_t nextId = di.nextZoneId;
        di.nextZoneId++;
        [[SingletonCluster getSharedInstance].dataController save:di];
        return nextId;
    }

@end
