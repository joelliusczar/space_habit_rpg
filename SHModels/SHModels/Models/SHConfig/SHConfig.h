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
@property (class, assign, nonatomic) int32_t dayStartTime;
@property (class, assign, nonatomic) int32_t weeklyStartDay;
@property (class, assign, nonatomic) SHGameState gameState;
@property (class, assign, nonatomic) SHStoryMode storyMode;
@property (class, assign, nonatomic) SHStoryState storyState;
@property (class, nonatomic) struct SHDatetime *lastProcessingDateTime;
@end
NS_ASSUME_NONNULL_END

