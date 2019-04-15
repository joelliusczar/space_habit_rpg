//
//  SHCounter+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHCounter+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHCounter (CoreDataProperties)

+ (NSFetchRequest<SHCounter *> *)fetchRequest;

@property (nonatomic) int32_t difficulty;
@property (nonatomic) int32_t freeViolations;
@property (nullable, nonatomic, copy) NSString *frequencyCounts;
@property (nullable, nonatomic, copy) NSString *habitName;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isGood;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) BOOL neglectPunishReward;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t urgency;
@property (nonatomic) int32_t userOrder;
@property (nullable, nonatomic, retain) SHCategory *cat_counter;
@property (nullable, nonatomic, retain) SHDaily *trigger_daily;

@end

NS_ASSUME_NONNULL_END
