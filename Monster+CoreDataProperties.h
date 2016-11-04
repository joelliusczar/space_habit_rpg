//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Monster.h"

NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nonatomic) int32_t baseXpReward;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nullable, nonatomic, retain) NSString *monsterName;
@property (nonatomic) int32_t nowHp;

@end

NS_ASSUME_NONNULL_END
