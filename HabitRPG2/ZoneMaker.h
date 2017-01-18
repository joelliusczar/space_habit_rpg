//
//  ZoneMaker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStackController.h"
#import "Hero+CoreDataClass.h"
#import "Zone+CoreDataClass.h"



@interface ZoneMaker : NSObject
+(instancetype)constructWithDataController:(CoreDataStackController *)dataController;
-(instancetype)initWithDataController:(CoreDataStackController *)dataController;
-(Zone *)constructHomeZone;
-(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
-(NSArray<Zone *> *)constructMultipleZoneChoices:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
-(Zone *)getZoneByZoneKey:(NSString *)zoneKey;
-(Zone * )constructEmptyZone;
-(int64_t)getNextUniqueId;
@end
