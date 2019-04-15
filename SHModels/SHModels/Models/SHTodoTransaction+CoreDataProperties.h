//
//  SHTodoTransaction+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodoTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHTodoTransaction (CoreDataProperties)

+ (NSFetchRequest<SHTodoTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *misc;
@property (nullable, nonatomic, copy) NSDate *timestamp;

@end

NS_ASSUME_NONNULL_END
