//
//  ZoneMaker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/23/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStackController.h"
#import "Zone.h"
#import "Hero.h"

@interface ZoneMaker : NSObject
-(id)initWithDataController:(CoreDataStackController*)dataController;
-(Zone *)constructHomeZone;
-(Zone *)constructZoneChoice:(Hero *)hero AndMatchHeroLvl:(BOOL)matchLvl;
@end
