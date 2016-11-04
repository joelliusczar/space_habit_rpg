//
//  Todo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Todo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

@property (nonatomic) int16_t difficulty;
@property (nonatomic) NSTimeInterval dueDate;
@property (nonatomic) NSTimeInterval effectiveDate;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *todoName;
@property (nonatomic) int16_t urgency;

@end

NS_ASSUME_NONNULL_END
