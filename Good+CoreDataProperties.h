//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Good.h"

NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

@property (nonatomic) int32_t cost;
@property (nullable, nonatomic, retain) NSString *goodName;
@property (nullable, nonatomic, retain) NSString *note;
@property (nonatomic) int16_t useType;

@end

NS_ASSUME_NONNULL_END
