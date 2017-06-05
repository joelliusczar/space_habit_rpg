//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Good+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest;

@property (nonatomic) int32_t cost;
@property (nullable, nonatomic, copy) NSString *goodName;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t useType;

@end

NS_ASSUME_NONNULL_END
