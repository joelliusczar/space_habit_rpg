//
//  Reminder+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SHReminderDTO.h"


@class Daily;

NS_ASSUME_NONNULL_BEGIN

@interface Reminder : NSManagedObject
@property (readonly,weak,nonatomic) NSString *synopsis;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyInto:(NSObject *)object;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "Reminder+CoreDataProperties.h"
