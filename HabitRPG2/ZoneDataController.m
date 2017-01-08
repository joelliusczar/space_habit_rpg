//
//  ZoneDataController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneDataController.h"

@implementation ZoneDataController

-(Zone *)getZoneByZoneKey:(NSString *)zoneKey{
    NSFetchRequest<Zone *> *request = [Zone fetchRequest];
    request.fetchLimit = 1;
    NSSortDescriptor *sortBySuffixNumber= [[NSSortDescriptor alloc] initWithKey:@"suffixNumber" ascending:NO];
    request.predicate = [NSPredicate predicateWithFormat:@"zoneKey = %@",zoneKey];
    request.sortDescriptors = @[sortBySuffixNumber];
    NSError *err;
    
    NSArray *results = [self.context executeFetchRequest:request error:&err];
    if(!results&&err){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return nil;
    }
    if(results.count < 1){
        return nil;
    }
    return (Zone *)[results objectAtIndex:0];
}

-(Zone *)constructEmptyZone{
    return (Zone *)[self constructEmptyEntity:ZONE_ENTITY_NAME];
}

-(int64_t)getNextUniqueId{
    int64_t nextId = self.userData.theDataInfo.nextZoneId;
    self.userData.theDataInfo.nextZoneId++;
    [self save];
    return nextId;
}

@end
