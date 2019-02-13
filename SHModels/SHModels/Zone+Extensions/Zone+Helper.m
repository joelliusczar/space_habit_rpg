//
//  Zone+Helper.m
//  SHModels
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "Zone+Helper.h"
#import "ModelConstants.h"
#import "Suffix+CoreDataClass.h"
#import "ModelTools.h"
#import "SingletonCluster+Entity.h"

NSString* const HOME_KEY = @"HOME";
@interface Zone ()
Suffix* getSuffixEntity(NSString* zoneKey);
int32_t getVisitCountForZone(NSString* zoneKey);
@end

@implementation Zone (Helper)

/*
 We're adding the zone groups to a list and one of them will be randomly selected
 */
NSArray<NSString *>* getUnlockedZoneGroupKeys(NSUInteger heroLvl){
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

NSString* getRandomZoneDefinitionKey(NSUInteger heroLvl){
    NSArray<NSString *> *groupKeys = getUnlockedZoneGroupKeys(heroLvl);
    uint r = randomUInt((uint)groupKeys.count);
    NSString *groupKey = groupKeys[r];
    ZoneInfoDictionary *zd = SharedGlobal.zoneInfoDictionary;
    NSArray *zoneList = [zd getGroupKeyList:groupKey];
    r = randomUInt((uint32_t)zoneList.count);
    return zoneList[r];
}

NSString* getSymbolSuffix(NSUInteger visitCount){
    NSMutableArray<NSString *> *suffixList = [NSMutableArray array];
    NSArray *symbols = getSymbolsList();
    while(visitCount > 0){
        NSUInteger m = (visitCount-1) % symbols.count;
        visitCount -= m;
        visitCount /= symbols.count;
        [suffixList addObject:symbols[m]];
    }
    return [[[suffixList reverseObjectEnumerator] allObjects] componentsJoinedByString:@" "];
}

NSArray<NSString*>* getSymbolsList(){
    NSBundle *bundle = [NSBundle bundleForClass:Zone.class];
    NSArray *symbols = [SharedGlobal.resourceUtility getPListArray:@"SuffixList"
      withBundle:bundle];
    
    return symbols;
}


Zone* constructRandomZoneChoice(Hero* hero,BOOL shouldMatchLvl){
  NSString *zoneKey = getRandomZoneDefinitionKey(hero.lvl);
  int32_t zoneLvl = shouldMatchLvl?hero.lvl:calculateLvl(hero.lvl,ZONE_LVL_RANGE);
  Zone *z = constructSpecificZone2(zoneKey,zoneLvl);
  return z;
}


Zone* constructEmptyZone(){
  //if we change here update afterZonePick
  NSEntityDescription *entity = Zone.entity;
  return [[Zone alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}


Zone* constructSpecificZone2(NSString* zoneKey,int32_t lvl){
  int32_t monsterCount = randomUInt(MAX_MONSTER_RAND_UP_BOUND) + MAX_MONSTER_LOW_BOUND;
  return constructSpecificZone(zoneKey, lvl, monsterCount);
}


Zone* constructSpecificZone(NSString* zoneKey, int32_t lvl,int32_t monsterCount){
  
  NSCAssert(zoneKey,@"Key can't be null");
  NSCAssert(lvl > 0, @"Lvl must be greater than 0");
  Zone *z = constructEmptyZone();
  z.zoneKey = zoneKey;
  z.suffix = getSymbolSuffix(getVisitCountForZone(zoneKey));
  z.maxMonsters = monsterCount;
  z.monstersKilled = 0;
  z.lvl = lvl;
  return z;
}


NSMutableArray<Zone*>* constructMultipleZoneChoices(Hero* hero,BOOL matchLvl){
    //Zone create uses nil context so that should be okay
  
  
    [SHData beginUsingTemporaryContext];
    uint zoneCount = randomUInt(MAX_ZONE_CHOICE_RAND_UP_BOUND)  + MIN_ZONE_CHOICE_COUNT;
    NSMutableArray<Zone *> *choices = [NSMutableArray arrayWithCapacity:zoneCount];
    choices[0] = constructRandomZoneChoice(hero,matchLvl);
    for(uint i = 1;i<zoneCount;i++){
        choices[i] = constructRandomZoneChoice(hero,NO);
    }
    [SHData endUsingTemporaryContext];
    return choices;
}


int32_t getVisitCountForZone(NSString* zoneKey){
    Suffix *s = getSuffixEntity(zoneKey);
    int currentVisitCount = s.visitCount++;
    [SHData saveAndWait];
    return currentVisitCount;
}

Suffix* getSuffixEntity(NSString* zoneKey){
    NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
    NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    NSArray<NSManagedObject *> *results = [SHData getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];
    NSCAssert(results.count<2, @"There are too many entities");
    Suffix *s;
    if(results.count){
        s = (Suffix *)results[0];
    }
    else{
        s = (Suffix *)[SHData constructEmptyEntity:Suffix.entity];
        s.zoneKey = zoneKey;
    }
    return s;
}


Zone * getZone(BOOL isFront){
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%d",isFront?1:0];
    NSArray<NSManagedObject *> *results = getAllZones(filter);
    if(results.count > 1){
      @throw [NSException exceptionWithName:@"CorruptionException"
        reason:@"There are too many zones" userInfo:nil];
    }
    return results.count>0?(Zone *)results[0]:nil;
}

NSArray<NSManagedObject *>* getAllZones(NSPredicate* filter){
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
    NSArray<NSManagedObject *> *results = [SHData getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];
    return results;
}

-(void)moveZoneToFront{
    NSArray<NSManagedObject *> *results = getAllZones(nil);
    self.isFront = YES;
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
