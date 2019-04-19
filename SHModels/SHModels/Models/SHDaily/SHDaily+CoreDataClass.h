//
//  SHDaily+CoreDataClass.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHCategory, SHCounter, SHDailySubTask, SHItem, SHReminder;

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
