//
//  DailyTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/9/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DailyTransaction (CoreDataProperties)

+ (NSFetchRequest<DailyTransaction *> *)fetchRequest;

@property (nonatomic) int32_t action;
@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, retain) Daily *transaction_daily;

@end

NS_ASSUME_NONNULL_END
