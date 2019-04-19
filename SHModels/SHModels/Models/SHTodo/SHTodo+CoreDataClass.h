//
//  SHTodo+CoreDataClass.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHCategory, SHItem;

NS_ASSUME_NONNULL_BEGIN

@interface SHTodo : NSManagedObject
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@end

NS_ASSUME_NONNULL_END

#import "SHTodo+CoreDataProperties.h"
