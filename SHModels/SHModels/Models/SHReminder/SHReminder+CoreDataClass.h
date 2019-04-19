//
//  SHReminder+CoreDataClass.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SHDaily;

NS_ASSUME_NONNULL_BEGIN

@interface SHReminder : NSManagedObject
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "SHReminder+CoreDataProperties.h"
