//
//  SHConfig.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;
@import SHGlobal;

NS_ASSUME_NONNULL_BEGIN

@interface SHConfig : NSObject
@property (readonly, nonatomic) NSDate *userTodayStart;
@property (assign, nonatomic) NSInteger dayStartTime;
@property (assign, nonatomic) SHGameState gameState;
@property (assign, nonatomic) SHStoryMode storyMode;
@property (assign, nonatomic) SHStoryState storyState;
@end
NS_ASSUME_NONNULL_END

