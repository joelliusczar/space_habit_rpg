//
//  Todo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *difficulty;
@property (nullable, nonatomic, retain) NSDate *dueDate;
@property (nullable, nonatomic, retain) NSDate *effectiveDate;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *todoName;
@property (nullable, nonatomic, retain) NSNumber *urgency;

@end

NS_ASSUME_NONNULL_END
