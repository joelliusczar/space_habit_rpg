//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Monster.h"

NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *monsterName;
@property (nullable, nonatomic, retain) NSNumber *maxHp;
@property (nullable, nonatomic, retain) NSNumber *nowHp;
@property (nullable, nonatomic, retain) NSNumber *lvl;
@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSNumber *baseXpReward;

@end

NS_ASSUME_NONNULL_END
