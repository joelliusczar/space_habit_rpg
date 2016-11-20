//
//  ZoneMaker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStackController.h"
#import "constants.h"
#import "ZoneDescriptions.h"
#import "ZoneHelper.h"
#import "stdlib.h"
#import "CommonUtilities.h"
#import "Zone+CoreDataClass.h"
#import "Hero+CoreDataClass.h"
#import "DataInfo+CoreDataClass.h"

@interface ZoneMaker : NSObject
-(id)initWithDataController:(CoreDataStackController*)dataController;
-(Zone *)constructHomeZone;
-(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
@end
