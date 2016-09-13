//
//  Zone+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Zone.h"

NS_ASSUME_NONNULL_BEGIN

@interface Zone (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSNumber *lvl;
@property (nullable, nonatomic, retain) NSNumber *maxMonsters;
@property (nullable, nonatomic, retain) NSNumber *monstersKilled;
@property (nullable, nonatomic, retain) NSNumber *previousZonePK;
@property (nullable, nonatomic, retain) NSString *suffix;
@property (nullable, nonatomic, retain) NSString *zoneName;

@end

NS_ASSUME_NONNULL_END
