//
//  Daily+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Daily (CoreDataProperties)

+ (NSFetchRequest<Daily *> *)fetchRequest;

@property (nonatomic) int32_t activeDaysHash;
@property (nonatomic) int32_t customUserOrder;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, copy) NSDate *lastActivationTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t rate;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int32_t urgency;
@property (nullable, nonatomic, retain) NSOrderedSet<DailyReminders *> *daily_remind;
@property (nullable, nonatomic, retain) NSOrderedSet<DailySubTask *> *daily_subtask;

@end

@interface Daily (CoreDataGeneratedAccessors)

- (void)insertObject:(DailyReminders *)value inDaily_remindAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDaily_remindAtIndex:(NSUInteger)idx;
- (void)insertDaily_remind:(NSArray<DailyReminders *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDaily_remindAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDaily_remindAtIndex:(NSUInteger)idx withObject:(DailyReminders *)value;
- (void)replaceDaily_remindAtIndexes:(NSIndexSet *)indexes withDaily_remind:(NSArray<DailyReminders *> *)values;
- (void)addDaily_remindObject:(DailyReminders *)value;
- (void)removeDaily_remindObject:(DailyReminders *)value;
- (void)addDaily_remind:(NSOrderedSet<DailyReminders *> *)values;
- (void)removeDaily_remind:(NSOrderedSet<DailyReminders *> *)values;

- (void)insertObject:(DailySubTask *)value inDaily_subtaskAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDaily_subtaskAtIndex:(NSUInteger)idx;
- (void)insertDaily_subtask:(NSArray<DailySubTask *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDaily_subtaskAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDaily_subtaskAtIndex:(NSUInteger)idx withObject:(DailySubTask *)value;
- (void)replaceDaily_subtaskAtIndexes:(NSIndexSet *)indexes withDaily_subtask:(NSArray<DailySubTask *> *)values;
- (void)addDaily_subtaskObject:(DailySubTask *)value;
- (void)removeDaily_subtaskObject:(DailySubTask *)value;
- (void)addDaily_subtask:(NSOrderedSet<DailySubTask *> *)values;
- (void)removeDaily_subtask:(NSOrderedSet<DailySubTask *> *)values;

@end

NS_ASSUME_NONNULL_END
