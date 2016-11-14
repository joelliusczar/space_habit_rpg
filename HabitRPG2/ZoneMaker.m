//
//  ZoneMaker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneMaker.h"
#include "CoreDataStackController.h"
#import "constants.h"
#import "ZoneDescriptions.h"
#import "ZoneHelper.h"
#import "stdlib.h"
#import "CommonUtilities.h"

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

-(id)initWithDataController:(CoreDataStackController*)dataController{
    if(self = [self init]){
        self.dataController = dataController;
    }
    return self;
}


-(Zone *)constructHomeZone{
    Zone *z = (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
    z.isCurrentZone_H = YES;
    z.previousZonePK_H = -1;
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffixNumber = 0;
    //z.uniqueId = [NSUuid];
    [self.dataController save];
    return z;
}

-(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl_H];
    z.zoneKey = zoneKey;
    z.suffixNumber_H = [self getVisitCountForZone:zoneKey];
    z.maxMonsters_H = arc4random_uniform(10) + 5;
    z.monstersKilled = 0;
    z.lvl_H = matchLvl?hero.lvl_H:[self.util calculateLvl:hero.lvl_H OffsetBy:10];
    return z;
}

-(int32_t)getVisitCountForZone:(NSString *)zoneKey{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    NSSortDescriptor *sortByAnything = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSFetchedResultsController *fetchResults = [self.dataController getItemFetcher:ZONE_ENTITY_NAME predicate:predicate sortBy:@[sortByAnything]];
    NSError *err;
    if(![fetchResults performFetch:&err]){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return -1;
    }
    
    return (int32_t)fetchResults.fetchedObjects.count;
}

@end


