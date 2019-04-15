//
//  SHTodo+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHTodo (CoreDataProperties)

+ (NSFetchRequest<SHTodo *> *)fetchRequest;

@property (nonatomic) int32_t difficulty;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nullable, nonatomic, copy) NSDate *effectiveDate;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *todoName;
@property (nonatomic) int32_t urgency;
@property (nonatomic) int32_t userOrder;
@property (nullable, nonatomic, retain) SHCategory *cat_todo;
@property (nullable, nonatomic, retain) SHItem *todo_itemReward;

@end

NS_ASSUME_NONNULL_END
