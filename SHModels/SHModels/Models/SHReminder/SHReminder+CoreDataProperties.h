//
//  SHReminder+CoreDataProperties.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHReminder+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHReminder (CoreDataProperties)

+ (NSFetchRequest<SHReminder *> *)fetchRequest;

@property (nonatomic) int32_t daysBeforeDue;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nullable, nonatomic, copy) NSString *notificationID;
@property (nonatomic) int32_t reminderHour;
@property (nullable, nonatomic, retain) SHDaily *remind_daily;

@end

NS_ASSUME_NONNULL_END
