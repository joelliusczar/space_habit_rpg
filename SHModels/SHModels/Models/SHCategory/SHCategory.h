//
//  SHCategory.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHCounter, SHDaily, SHTeapot, SHTodo;

NS_ASSUME_NONNULL_BEGIN

@interface SHCategory : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "SHCategory+CoreDataProperties.h"
