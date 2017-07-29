//
//  DataInfo+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DataInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DataInfo (CoreDataProperties)

+ (NSFetchRequest<DataInfo *> *)fetchRequest;

@property (nonatomic) int32_t gameState;
@property (nonatomic) int32_t migrationNumber;
@property (nonatomic) int64_t nextZoneId;
@property (nullable, nonatomic, copy) NSDate *lastUpdateTime;

@end

NS_ASSUME_NONNULL_END
