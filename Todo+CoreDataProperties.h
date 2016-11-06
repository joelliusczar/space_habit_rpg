//
//  Todo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Todo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *difficulty;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nullable, nonatomic, copy) NSDate *effectiveDate;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *todoName;
@property (nullable, nonatomic, copy) NSNumber *urgency;

@end

NS_ASSUME_NONNULL_END
