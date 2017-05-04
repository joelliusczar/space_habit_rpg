//
//  TodoTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TodoTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TodoTransaction (CoreDataProperties)

+ (NSFetchRequest<TodoTransaction *> *)fetchRequest;

@property (nonatomic) int32_t action;
@property (nullable, nonatomic, copy) NSDate *activationTime;
@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, retain) Todo *transaction_todo;

@end

NS_ASSUME_NONNULL_END
