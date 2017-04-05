//
//  Zone+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Zone : NSManagedObject
@property (nonatomic,strong,readonly) NSString *fullName;
@property (nonatomic,strong,readonly) NSString *synopsis;
@end

NS_ASSUME_NONNULL_END

#import "Zone+CoreDataProperties.h"
