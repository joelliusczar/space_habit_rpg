//
//  DataInfo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "DataInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataInfo (CoreDataProperties)

+ (NSFetchRequest<DataInfo *> *)fetchRequest;

@property (nonatomic) int64_t nextZoneId;

@end

NS_ASSUME_NONNULL_END
