//
//  SHDaily.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDueDateItemProtocol.h"
#import "SHDailyActiveDays.h"
#import "SHTitleProtocol.h"
@import Foundation;
@import CoreData;
@import SHCommon;

@class SHCategory, SHCounter, SHDailySubTask,
	SHItem, SHReminder, SHDailyEvent;
	
typedef NS_ENUM(NSInteger,SHDailyStatus) {
	SH_DAILY_STATUS_NOT_DUE = 0,
	SH_DAILY_STATUS_DUE = 1 << 0,
	SH_DAILY_STATUS_COMPLETE = 1 << 1
};

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject<SHDueDateItemProtocol, SHTitleProtocol>
@property (strong, nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (readonly, nonatomic) NSInteger rate;
@property (readonly, nonatomic) BOOL isCompleted;
@property (readonly, nonatomic) BOOL isActiveToday;
@property (readonly, nonatomic) SHDailyStatus dailyStatus;
@property (strong, nonatomic) NSObject<SHDateProviderProtocol> *dateProvider;
-(void)setupInitialState;
-(NSArray<SHDailyEvent *> *)lastActivations:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
