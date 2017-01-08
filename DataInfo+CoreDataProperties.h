//
//  DataInfo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DataInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataInfo (CoreDataProperties)

+ (NSFetchRequest<DataInfo *> *)fetchRequest;

@property (nonatomic) int64_t nextZoneId;
@property (nonatomic) BOOL isNew;

@end

NS_ASSUME_NONNULL_END
