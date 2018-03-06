//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/28/17.
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
@property (nullable, nonatomic, copy) NSDate *lastUpdateTime;

@end

NS_ASSUME_NONNULL_END