//
//  SHDailySubTask+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDailySubTask+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHDailySubTask (CoreDataProperties)

+ (NSFetchRequest<SHDailySubTask *> *)fetchRequest;

@property (nonatomic) int32_t activeDaysHash;
@property (nullable, nonatomic, copy) NSString *dailySubTaskName;
@property (nonatomic) int32_t difficulty;
@property (nullable, nonatomic, copy) NSDate *lastActivationDateTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) int32_t rate;
@property (nonatomic) int32_t urgency;
@property (nullable, nonatomic, retain) SHDaily *subtask_daily;

@end

NS_ASSUME_NONNULL_END
