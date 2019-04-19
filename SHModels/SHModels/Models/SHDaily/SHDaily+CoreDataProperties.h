//
//  SHDaily+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHDaily (CoreDataProperties)

+ (NSFetchRequest<SHDaily *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *activeDays;
@property (nonatomic) int32_t customUserOrder;
@property (nonatomic) int32_t cycleStartTime;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, copy) NSDate *lastActivationDateTime;
@property (nullable, nonatomic, copy) NSDate *lastDueDateTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t rate;
@property (nonatomic) int32_t rateType;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationDateTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int32_t urgency;
@property (nullable, nonatomic, copy) NSDate *activeFromDate;
@property (nullable, nonatomic, copy) NSDate *activeToDate;
@property (nullable, nonatomic, retain) NSOrderedSet<SHReminder *> *daily_remind;
@property (nullable, nonatomic, retain) NSOrderedSet<SHDailySubTask *> *daily_subtask;
@property (nullable, nonatomic, retain) SHCategory *daily_cat;
@property (nullable, nonatomic, retain) SHItem *daily_itemReward;
@property (nullable, nonatomic, retain) SHCounter *trigger_daily;

@end

@interface SHDaily (CoreDataGeneratedAccessors)

- (void)insertObject:(SHReminder *)value inDaily_remindAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDaily_remindAtIndex:(NSUInteger)idx;
- (void)insertDaily_remind:(NSArray<SHReminder *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDaily_remindAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDaily_remindAtIndex:(NSUInteger)idx withObject:(SHReminder *)value;
- (void)replaceDaily_remindAtIndexes:(NSIndexSet *)indexes withDaily_remind:(NSArray<SHReminder *> *)values;
- (void)addDaily_remindObject:(SHReminder *)value;
- (void)removeDaily_remindObject:(SHReminder *)value;
- (void)addDaily_remind:(NSOrderedSet<SHReminder *> *)values;
- (void)removeDaily_remind:(NSOrderedSet<SHReminder *> *)values;

- (void)insertObject:(SHDailySubTask *)value inDaily_subtaskAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDaily_subtaskAtIndex:(NSUInteger)idx;
- (void)insertDaily_subtask:(NSArray<SHDailySubTask *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDaily_subtaskAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDaily_subtaskAtIndex:(NSUInteger)idx withObject:(SHDailySubTask *)value;
- (void)replaceDaily_subtaskAtIndexes:(NSIndexSet *)indexes withDaily_subtask:(NSArray<SHDailySubTask *> *)values;
- (void)addDaily_subtaskObject:(SHDailySubTask *)value;
- (void)removeDaily_subtaskObject:(SHDailySubTask *)value;
- (void)addDaily_subtask:(NSOrderedSet<SHDailySubTask *> *)values;
- (void)removeDaily_subtask:(NSOrderedSet<SHDailySubTask *> *)values;

@end

NS_ASSUME_NONNULL_END
