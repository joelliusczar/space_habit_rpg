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
    z.isCurrentZone = YES;
    z.previousZonePK = -1;
    z.zoneKey = HOME_KEY;
    z.lvl = 0;
    z.maxMonsters = 0;
    z.monstersKilled = 0;
    z.suffixNumber = 0;
    z.uniqueId = 0;
    [self.dataController save];
    return z;
}

-(int64_t)getNextUniqueId{
    NSFetchRequest<DataInfo *> *request = [DataInfo fetchRequest];
    request.fetchLimit = 1;
    request.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"nextZoneId" ascending:NO]];
    request.propertiesToFetch = @[@"nextZoneId"];
    NSError *err;
    NSArray *results = [self.dataController.context executeFetchRequest:request error:&err];
    if(!results){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return -1;
    }
    if(results.count < 1){
        return 0;
    }
    return (int64_t)((NSNumber *)[results objectAtIndex:0]).integerValue;
}

-(Zone *)constructZoneChoice:(nonnull Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl{
    Zone *z = (Zone *)[self.dataController constructEmptyEntity:ZONE_ENTITY_NAME];
    NSString *zoneKey = [ZoneHelper getRandomZoneDefinitionKey:hero.lvl];
    z.zoneKey = zoneKey;
    z.suffixNumber = [self getVisitCountForZone:zoneKey];
    z.maxMonsters = arc4random_uniform(MAX_MONSTER_RAND_UP_BOUND) + MAX_MONSTER_LOW_BOUND;
    z.monstersKilled = 0;
    z.lvl = matchLvl?hero.lvl:[self.util calculateLvl:hero.lvl OffsetBy:ZONE_LVL_RANGE];
    return z;
}

-(int32_t)getVisitCountForZone:(NSString *)zoneKey{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    request.fetchLimit = 1;
    NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    request.sortDescriptors = @[sortBySuffixNumber];
    NSError *err;
    
    NSArray *results = [self.dataController.context executeFetchRequest:request error:&err];
    if(!results&&err){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return -1;
    }
    
    if(!results){
        return 0;
    }
    
    Zone * z = (Zone *)[results objectAtIndex:0];
    int32_t visitCount = z.suffixNumber;
    return visitCount+1;
}

@end


