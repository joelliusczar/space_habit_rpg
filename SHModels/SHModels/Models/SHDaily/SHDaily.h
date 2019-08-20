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
#import "SHTitleProtocol.h"

@class SHCategory, SHCounter, SHDailySubTask, SHItem, SHReminder;

NS_ASSUME_NONNULL_BEGIN

@interface SHDaily : NSManagedObject<SHDueDateItemProtocol, SHTitleProtocol>
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
-(void)setupInitialState;
@property (readonly,nonatomic) int32_t rate;
@property (readonly,nonatomic) BOOL isCompleted;
@end

NS_ASSUME_NONNULL_END

#import "SHDaily+CoreDataProperties.h"
