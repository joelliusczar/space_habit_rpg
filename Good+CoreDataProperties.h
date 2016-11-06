//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Good+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *cost;
@property (nullable, nonatomic, copy) NSString *goodName;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSNumber *useType;

@end

NS_ASSUME_NONNULL_END
