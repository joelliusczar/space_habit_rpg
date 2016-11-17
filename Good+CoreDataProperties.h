//
//  Good+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Good+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest;

@property (nonatomic) int32_t cost;
@property (nullable, nonatomic, copy) NSString *goodName;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int16_t useType;

@end

NS_ASSUME_NONNULL_END
