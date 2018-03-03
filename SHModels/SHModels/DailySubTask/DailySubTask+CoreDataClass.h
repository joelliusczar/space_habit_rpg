//
//  DailySubTask+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Daily;

NS_ASSUME_NONNULL_BEGIN

@interface DailySubTask : NSManagedObject
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyInto:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "DailySubTask+CoreDataProperties.h"
