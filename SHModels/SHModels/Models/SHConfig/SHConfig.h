//
//  SHConfig.h
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

@import Foundation;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHConfig : NSObject
@property (readonly, nonatomic) NSDate *userTodayStart;
@property (assign, nonatomic) NSInteger dayStartTime;
@property (assign, nonatomic) NSInteger gameState;
@property (assign, nonatomic) NSInteger storyMode;
@end

NS_ASSUME_NONNULL_END

