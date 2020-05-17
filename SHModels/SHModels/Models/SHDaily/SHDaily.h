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
#import "SHDailyNextDueDateCalculator.h"
@import Foundation;
@import CoreData;
@import SHCommon;

@class SHCategory, SHCounter, SHDailySubTask,
	SHItem, SHReminder, SHDailyEvent;
	
typedef NS_ENUM(NSInteger,SHDailyStatus) {
	SH_DAILY_STATUS_NOT_DUE = 0,
	SH_DAILY_STATUS_DUE = 1 << 0,
	SH_DAILY_STATUS_COMPLETE = 1 << 1,
	SH_DAILY_STATUS_UNKNOWN = 1 << 2
};

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject<SHDueDateItemProtocol, SHTitleProtocol>
@property (strong, nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (readonly, nonatomic) NSInteger intervalSize;
@property (readonly, nonatomic) BOOL isActiveToday;
@property (class, nonatomic) id<SHDateProviderProtocol> dateProvider;
@property (readonly, strong, nonatomic) SHDailyNextDueDateCalculator *calculator;
-(void)setupInitialState;
-(NSArray<SHDailyEvent *> *)lastActivations:(NSInteger)count;
-(void)updateDailyStatus;
@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
