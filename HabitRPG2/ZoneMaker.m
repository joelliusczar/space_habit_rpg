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
#import "ZoneDataController.h"


@interface ZoneMaker()
@property (nonatomic,weak) ZoneDataController *dataController;
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
        self.dataController = (ZoneDataController *)dataController;
    }
    return self;
}

-(Zone *)constructHomeZone{
    Zone *z = (Zone *)[self.dataController constructEmptyZone];
    z.previousZone = nil;
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffixNumber = 0;
    z.uniqueId = [self.dataController getNextUniqueId];
    [self.dataController save];
    return z;
}

-(Zone *)constructZoneChoice:(nonnull Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = (Zone *)[self.dataController constructEmptyZone];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl];
    z.zoneKey = zoneKey;
    z.suffixNumber = [self getVisitCountForZone:zoneKey];
    z.maxMonsters = arc4random_uniform(MAX_MONSTER_RAND_UP_BOUND) + MAX_MONSTER_LOW_BOUND;
    z.monstersKilled = 0;
    z.lvl = matchLvl?hero.lvl:[self.util calculateLvl:hero.lvl OffsetBy:ZONE_LVL_RANGE];
    return z;
}

-(int32_t)getVisitCountForZone:(NSString *)zoneKey{
    Zone * z = [self.dataController getZoneByZoneKey:zoneKey];
    int32_t visitCount = z.suffixNumber;
    return visitCount+1;
}

@end


