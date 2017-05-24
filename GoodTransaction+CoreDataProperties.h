//
//  GoodTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "GoodTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface GoodTransaction (CoreDataProperties)

+ (NSFetchRequest<GoodTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *timestamp;
@property (nullable, nonatomic, copy) NSString *misc;

@end

NS_ASSUME_NONNULL_END
