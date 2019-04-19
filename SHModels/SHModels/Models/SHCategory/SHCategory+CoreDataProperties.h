//
//  SHCategory+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHCategory+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHCategory (CoreDataProperties)

+ (NSFetchRequest<SHCategory *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t colorNum;

@end

NS_ASSUME_NONNULL_END
