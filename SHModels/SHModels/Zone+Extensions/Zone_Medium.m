//
//  Zone_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 2/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/CommonUtilities.h>
#import "Suffix+CoreDataClass.h"
#import "ModelTools.h"
#import "ModelConstants.h"
#import "Zone_Medium.h"

NSString* const HOME_KEY = @"HOME";

@interface Zone_Medium ()
@property (strong,nonatomic) NSObject<P_CoreData>* dataController;
@property (strong,nonatomic) NSObject<P_ResourceUtility>* resourceUtil;
@property (strong,nonatomic) ZoneInfoDictionary* zoneInfo;
@end

@implementation Zone_Medium

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
withResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil
withInfoDict:(ZoneInfoDictionary*)zoneInfo{
  Zone_Medium *instance = [[Zone_Medium alloc] init];
  instance.dataController = dataController;
  instance.resourceUtil = resourceUtil;
  instance.zoneInfo = zoneInfo;
  return instance;
}


-(NSArray<NSString*>*)getSymbolsList{
  NSBundle *bundle = [NSBundle bundleForClass:Zone.class];
  NSArray *symbols = [self.resourceUtil getPListArray:@"SuffixList" withBundle:bundle];

  return symbols;
}


-(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl{
    NSArray<NSString *> *groupKeys = getUnlockedZoneGroupKeys(heroLvl);
    uint r = randomUInt((uint)groupKeys.count);
    NSString *groupKey = groupKeys[r];
    ZoneInfoDictionary *zd = self.zoneInfo;
    NSArray *zoneList = [zd getGroupKeyList:groupKey];
    r = randomUInt((uint32_t)zoneList.count);
    return zoneList[r];
}


-(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
    NSMutableArray<NSString *> *suffixList = [NSMutableArray array];
    NSArray *symbols = [self getSymbolsList];
    while(visitCount > 0){
        NSUInteger m = (visitCount-1) % symbols.count;
        visitCount -= m;
        visitCount /= symbols.count;
        [suffixList addObject:symbols[m]];
    }
    return [[[suffixList reverseObjectEnumerator] allObjects] componentsJoinedByString:@" "];
}


-(Suffix*)getSuffixEntity:(NSString*)zoneKey{
  NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
  NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
  NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];

  NSArray<NSManagedObject *> *results = [self.dataController
    getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];

  NSCAssert(results.count<2, @"There are too many entities");
  Suffix *s;
  if(results.count){
      s = (Suffix *)results[0];
  }
  else{
      s = (Suffix *)[self.dataController constructEmptyEntity:Suffix.entity];
      s.zoneKey = zoneKey;
  }
  return s;
}


-(Zone*)constructEmptyZone{
  //if we change here update afterZonePick
  NSEntityDescription *entity = Zone.entity;
  return [[Zone alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
}


-(int32_t)getVisitCountForZone:(NSString*)zoneKey{
  Suffix *s = [self getSuffixEntity:zoneKey];
  int currentVisitCount = s.visitCount++;
  [self.dataController saveAndWait];
  return currentVisitCount;
}


-(Zone*)constructSpecificZone:(NSString*) zoneKey
withLvl:(int32_t)lvl withMonsterCount:(int32_t)monsterCount{
  
  NSCAssert(zoneKey,@"Key can't be null");
  NSCAssert(lvl > 0, @"Lvl must be greater than 0");
  Zone *z = [self constructEmptyZone];
  z.zoneKey = zoneKey;
  z.suffix = [self getSymbolSuffix:[self getVisitCountForZone:zoneKey]];
  z.maxMonsters = monsterCount;
  z.monstersKilled = 0;
  z.lvl = lvl;
  return z;
}


-(Zone*)constructSpecificZone2:(NSString*) zoneKey withLvl:(int32_t) lvl{
  int32_t monsterCount = randomUInt(MAX_MONSTER_RAND_UP_BOUND) + MAX_MONSTER_LOW_BOUND;
  return [self constructSpecificZone:zoneKey withLvl:lvl withMonsterCount: monsterCount];
}


-(Zone*)constructRandomZoneChoiceGivenHero:(Hero*)hero ifShouldMatchLvl:(BOOL)shouldMatchLvl{
  NSString *zoneKey = [self getRandomZoneDefinitionKey:hero.lvl];
  int32_t zoneLvl = shouldMatchLvl?hero.lvl:calculateLvl(hero.lvl,ZONE_LVL_RANGE);
  Zone *z = [self constructSpecificZone2:zoneKey withLvl:zoneLvl];
  return z;
}


-(NSMutableArray<Zone*>*)constructMultipleZoneChoicesGivenHero:(Hero*)hero ifShouldMatchLvl:(BOOL)matchLvl{
  //Zone create uses nil context so that should be okay

  [self.dataController beginUsingTemporaryContext];
  uint zoneCount = randomUInt(MAX_ZONE_CHOICE_RAND_UP_BOUND)  + MIN_ZONE_CHOICE_COUNT;
  NSMutableArray<Zone *> *choices = [NSMutableArray arrayWithCapacity:zoneCount];
  choices[0] = [self constructRandomZoneChoiceGivenHero:hero ifShouldMatchLvl:matchLvl];
  for(uint i = 1;i<zoneCount;i++){
      choices[i] = [self constructRandomZoneChoiceGivenHero:hero ifShouldMatchLvl:NO];
  }
  [self.dataController endUsingTemporaryContext];
  return choices;
}


-(NSArray<NSManagedObject*>*)getAllZones:(NSPredicate*) filter{
  NSFetchRequest<Zone *> *request = [Zone fetchRequest];
  NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];

  NSArray<NSManagedObject *> *results = [self.dataController
    getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];

  return results;
}


-(Zone*)getZone:(BOOL)isFront{
  NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%d",isFront?1:0];
  NSArray<NSManagedObject *> *results = [self getAllZones:filter];
  if(results.count > 1){
    @throw [NSException exceptionWithName:@"CorruptionException"
      reason:@"There are too many zones" userInfo:nil];
  }
  return results.count>0?(Zone *)results[0]:nil;
}


-(void)moveZoneToFront:(Zone*)zone{
  NSArray<Zone*> *results = [self getAllZones:nil];
  zone.isFront = YES;
  NSAssert(results.count<3, @"There are too many zones");
  if(results.count==0){
      return;
  }
  if(results.count==1){
      ((Zone *)results[0]).isFront = NO;
      return;
  }
  [self.dataController softDeleteModel:results[1]];
  ((Zone *)results[0]).isFront = NO;
}


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


@end
