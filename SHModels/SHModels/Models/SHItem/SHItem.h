//
//  SHItem.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@class SHDaily, SHTodo;

@interface SHItem : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "SHItem+CoreDataProperties.h"
