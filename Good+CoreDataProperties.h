//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Good.h"

NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *cost;
@property (nullable, nonatomic, retain) NSString *goodName;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSNumber *useType;

@end

NS_ASSUME_NONNULL_END
