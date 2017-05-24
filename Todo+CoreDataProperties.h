//
//  Todo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Todo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest;

@property (nonatomic) int32_t difficulty;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nullable, nonatomic, copy) NSDate *effectiveDate;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *todoName;
@property (nonatomic) int32_t urgency;

@end

NS_ASSUME_NONNULL_END
