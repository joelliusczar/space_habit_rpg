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
//userTodayStart is today's date with dayStartTime for the time of today
//it's more of a convenience property
@property (readonly, nonatomic) NSDate *userTodayStart;
//dayStartTime is the time of the day when a daily compared to to determine
//if daily is expired.
@property (assign, nonatomic) NSInteger dayStartTime;
@property (assign, nonatomic) NSInteger weeklyStartDay;
@property (assign, nonatomic) SHGameState gameState;
@property (assign, nonatomic) SHStoryMode storyMode;
@property (assign, nonatomic) SHStoryState storyState;
@end
NS_ASSUME_NONNULL_END

