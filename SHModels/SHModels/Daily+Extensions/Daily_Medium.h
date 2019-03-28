//
//  Daily_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 3/26/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily+CoreDataClass.h"

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface Daily_Medium : NSObject
+(instancetype)newWithSHData:(NSObject<P_CoreData> *)dataController;
-(Daily *)newDaily;
-(Daily *)newDailyWithContext:(nullable NSManagedObjectContext*)context;

-(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart
withContext:(NSManagedObjectContext*)context;

-(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart
withContext:(NSManagedObjectContext*)context;

@end

NS_ASSUME_NONNULL_END
