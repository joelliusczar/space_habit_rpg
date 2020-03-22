//
//  SHCounter.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;

@class SHCategory, SHDaily, SHCounterEvent;

NS_ASSUME_NONNULL_BEGIN

@interface SHCounter : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "SHCounter+CoreDataProperties.h"
