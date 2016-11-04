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
@end

@implementation ZoneMaker

-(id)initWithDataController:(CoreDataStackController*)dataController{
    if(self = [self init]){
        self.dataController = dataController;
    }
    return self;
}


-(Zone *)constructHomeZone{
    Zone *z = (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
    z.isCurrentZone = YES;
    z.previousZonePK = -1;
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffixNumber = 0;
    
    [self.dataController save];
    return z;
}

-(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl];
    z.zoneKey = zoneKey;
    z.suffixNumber = [self getVisitCountForZone:zoneKey];
    z.maxMonsters = arc4random_uniform(10) + 5;
    z.monstersKilled = 0;
    z.lvl = matchLvl?hero.lvl:[CommonUtilities calculateLvl:hero.lvl OffsetBy:10];
    return z;
}

-(NSUInteger)getVisitCountForZone:(NSString *)zoneKey{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    NSSortDescriptor *sortByAnything = [[NSSortDescriptor alloc] initWithKey:@"zoneKey" ascending:NO];
    NSFetchedResultsController *fetchResults = [self.dataController getItemFetcher:ZONE_ENTITY_NAME predicate:predicate sortBy:@[sortByAnything]];
    NSError *err;
    if(![fetchResults performFetch:&err]){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return -1;
    }
    
    return fetchResults.fetchedObjects.count;
}

@end


