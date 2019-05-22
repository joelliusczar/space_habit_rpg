//
//  SHDaily.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SHDueDateItemProtocol.h"
#import "SHDailyActiveDays.h"

@class SHCategory, SHCounter, SHDailySubTask, SHItem, SHReminder;

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject<SHDueDateItemProtocol>
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
-(void)setupInitialState;
@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
