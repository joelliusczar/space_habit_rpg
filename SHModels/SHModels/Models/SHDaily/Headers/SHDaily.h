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

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject<SHDueDateItemProtocol, SHTitleProtocol>
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (readonly,nonatomic) NSInteger rate;
@property (readonly,nonatomic) BOOL isCompleted;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol> *dateProvider;
-(void)setupInitialState;
-(NSArray<SHDailyEvent *> *)lastActivations:(NSInteger)count;
@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
