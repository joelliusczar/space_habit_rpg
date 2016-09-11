//
//  Monster+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Monster+CoreDataProperties.h"

@implementation Monster (CoreDataProperties)

@dynamic monsterName;
@dynamic maxHp;
@dynamic nowHp;
@dynamic lvl;
@dynamic about;
@dynamic baseXpReward;

@end
