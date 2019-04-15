//
//  SHDailyTransaction+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDailyTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHDailyTransaction (CoreDataProperties)

+ (NSFetchRequest<SHDailyTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, copy) NSDate *timestamp;

@end

NS_ASSUME_NONNULL_END
