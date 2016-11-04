//
//  Hero+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hero.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

@property (nonatomic) double gold;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nonatomic) int32_t maxXp;
@property (nonatomic) int32_t nowHp;
@property (nonatomic) int32_t nowXp;
@property (nullable, nonatomic, retain) NSString *shipName;

@end

NS_ASSUME_NONNULL_END
