//
//  SHReminderDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHObject.h>

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHReminderDTO : SHObject<NSCopying>
@property (readonly,weak,nonatomic) NSString *synopsis;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@property (assign,nonatomic) int32_t daysBeforeDue;
@property (copy,nullable,nonatomic) NSDate *reminderHour;
@property (copy,nonatomic) NSManagedObjectID *objectID;
@property (copy,nonatomic) void (^touchCallback)(void);
@end

NS_ASSUME_NONNULL_END
