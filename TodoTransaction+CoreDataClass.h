//
//  TodoTransaction+CoreDataClass.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

NS_ASSUME_NONNULL_BEGIN

@interface TodoTransaction : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "TodoTransaction+CoreDataProperties.h"
