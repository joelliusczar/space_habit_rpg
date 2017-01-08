//
//  ZoneDataController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "CoreDataStackController.h"
#import "Zone+CoreDataClass.h"


@interface ZoneDataController : CoreDataStackController
-(Zone *)getZoneByZoneKey:(NSString *)zoneKey;
-(Zone * )constructEmptyZone;
-(int64_t)getNextUniqueId;
@end
