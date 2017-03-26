//
//  ZoneMaker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneMaker.h"
#import "constants.h"
#import "ZoneDescriptions.h"
#import "ZoneHelper.h"
#import "stdlib.h"
#import "CommonUtilities.h"
#import "DataInfo+CoreDataClass.h"
#import "CoreDataStackController.h"
#import "Suffix+CoreDataClass.h"


@interface ZoneMaker()
@property (nonatomic,weak) CoreDataStackController *dataController;
@property (nonatomic,strong) CommonUtilities *util;
@end

@implementation ZoneMaker

@synthesize util = _util;
-(CommonUtilities *)util{
    if(_util == nil){
        _util = [[CommonUtilities alloc] init];
    }
    return _util;
}

-(instancetype)initWithDataController:(CoreDataStackController*)dataController{
    if(self = [self init]){
        self.dataController = dataController;
    }
    return self;
}

+(instancetype)constructWithDataController:(CoreDataStackController *)dataController{
    return [[ZoneMaker alloc] initWithDataController:dataController];
}

-(Zone *)constructHomeZone{
    Zone *z = [self constructEmptyZone];
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffixNumber = 0;
    z.uniqueId = [self getNextUniqueId];
    z.isFront = YES;
    [self.dataController save];
    return z;
}

-(Zone *)constructZoneChoice:(nonnull Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = [self constructEmptyZone];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl];
    z.zoneKey = zoneKey;
    z.suffixNumber = [self getVisitCountForZone:zoneKey];
    z.maxMonsters = arc4random_uniform(MAX_MONSTER_RAND_UP_BOUND) + MAX_MONSTER_LOW_BOUND;
    z.monstersKilled = 0;
    z.lvl = matchLvl?hero.lvl:[self.util calculateLvl:hero.lvl OffsetBy:ZONE_LVL_RANGE];
    return z;
}

-(NSArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    u_int32_t zoneCount = arc4random_uniform(MAX_ZONE_CHOICE_RAND_UP_BOUND) + MIN_ZONE_CHOICE_COUNT;
    NSMutableArray<Zone *> *choices = [NSMutableArray arrayWithCapacity:zoneCount];
    choices[0] = [self constructZoneChoice:hero AndMatchHeroLvl:matchLvl];
    for(u_int32_t i = 1;i<zoneCount;i++){
        choices[i] = [self constructZoneChoice:hero AndMatchHeroLvl:NO];
    }
    
    return [NSArray arrayWithArray:choices];
}

-(int32_t)getVisitCountForZone:(NSString *)zoneKey{    
    Suffix *s = [self getSuffix:zoneKey];
    return s.visitCount+1;
}

-(Suffix *)getSuffix:(NSString *)zoneKey{
    NSFetchRequest<Suffix *> *request = [Suffix fetchRequest];
    NSSortDescriptor *sortByZoneKey = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    return (Suffix *)[self.dataController getItemWithRequest:request predicate:filter sortBy:@[sortByZoneKey]];
}

//I think this may be unneeded. But I'll leave it alone for now.
//I think it is a relic of the graph way of storing previous zones.
-(Zone *)getZoneByZoneKey:(NSString *)zoneKey{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    
    return (Zone *)[self.dataController getItemWithRequest:request predicate:filter sortBy:@[sortBySuffixNumber]];
}

-(Zone *)constructEmptyZone{
    return (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
}

-(Zone *)getZone:(BOOL)isFront{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:YES];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isFront =%@",isFront];
    return (Zone *)[self.dataController getItemWithRequest:request predicate:filter sortBy:@[sortByIsFront]];
}

-(int64_t)getNextUniqueId{
    int64_t nextId = self.dataController.userData.theDataInfo.nextZoneId;
    self.dataController.userData.theDataInfo.nextZoneId++;
    [self.dataController save];
    return nextId;
}

@end


