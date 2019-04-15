//
//  SHItem+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHItem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHItem (CoreDataProperties)

+ (NSFetchRequest<SHItem *> *)fetchRequest;

@property (nonatomic) int32_t cost;
@property (nullable, nonatomic, copy) NSString *itemName;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t useType;

@end

NS_ASSUME_NONNULL_END
