//
//  SHReminderDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface ReminderDTO : NSObject
@property (assign,nonatomic) int32_t daysBeforeDue;
@property (copy,nullable,nonatomic) NSDate *reminderHour;
@property (copy,nonatomic) NSManagedObjectID *objectID;
@end

NS_ASSUME_NONNULL_END
