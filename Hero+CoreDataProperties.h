//
//  Hero+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hero.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *gold;
@property (nullable, nonatomic, retain) NSNumber *lvl;
@property (nullable, nonatomic, retain) NSNumber *maxHp;
@property (nullable, nonatomic, retain) NSNumber *maxXp;
@property (nullable, nonatomic, retain) NSNumber *nowHp;
@property (nullable, nonatomic, retain) NSNumber *nowXp;
@property (nullable, nonatomic, retain) NSString *shipName;
@property (nullable, nonatomic, retain) NSData *vistedZonesDict;

@end

NS_ASSUME_NONNULL_END
