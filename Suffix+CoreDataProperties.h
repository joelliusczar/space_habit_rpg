//
//  Suffix+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Suffix+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Suffix (CoreDataProperties)

+ (NSFetchRequest<Suffix *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *zoneKey;
@property (nonatomic) int32_t visitCount;

@end

NS_ASSUME_NONNULL_END
