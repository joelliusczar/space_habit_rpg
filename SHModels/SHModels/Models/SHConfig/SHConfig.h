//
//  SHConfig.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;
@import SHCommon;


NS_ASSUME_NONNULL_BEGIN

@interface SHConfig : NSObject
@property (class, strong, nonatomic) NSUserDefaults *userDefaults;
//userTodayStart is today's date with dayStartTime for the time of today
//it's more of a convenience property
@property (class, readonly, nonatomic) NSDate *userTodayStart;
//dayStartTime is the time of the day when a daily compared to to determine
//if daily is expired.
@property (class, assign, nonatomic) NSInteger dayStartTime;
@property (class, assign, nonatomic) NSInteger weeklyStartDay;
@property (class, assign, nonatomic) SHGameState gameState;
@property (class, assign, nonatomic) SHStoryMode storyMode;
@property (class, assign, nonatomic) SHStoryState storyState;
@property (class, copy, nonatomic) NSDate *lastProcessingDateTime;
@property (class, readonly, nonatomic) NSDate *lastProcessingDateDayStart;
@end
NS_ASSUME_NONNULL_END

