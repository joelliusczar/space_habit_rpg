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
#import "SHDBDueDateConstants.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHConfig : NSObject
@property (class, strong, nonatomic) NSUserDefaults *userDefaults;
//userTodayStart is today's date with dayStartTime for the time of today
//it's more of a convenience property
@property (class, nonatomic) int32_t dayStartTime;
@property (class, nonatomic) int32_t weeklyStartDay;
@property (class, nonatomic) SHGameState gameState;
@property (class, nonatomic) SHStoryMode storyMode;
@property (class, nonatomic) SHStoryState storyState;
@property (class, nonatomic) struct SHDatetime *lastProcessingDateTime;
@property (class, nonatomic) BOOL isAppInitialized;
@end
NS_ASSUME_NONNULL_END

