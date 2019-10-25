//
//  SHDailySubTask.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;

@class SHDaily;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailySubTask : NSManagedObject
-(NSMutableDictionary*)mappable;
-(void)copyFrom:(NSObject *)object;
@end

NS_ASSUME_NONNULL_END

#import "SHDailySubTask+CoreDataProperties.h"
