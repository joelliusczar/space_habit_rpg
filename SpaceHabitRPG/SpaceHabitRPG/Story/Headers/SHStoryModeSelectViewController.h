//
//  SHStoryModeSelectViewController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHStoryPresentationController.h"
@import SHCommon;
@import SHControls;

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryModeSelectViewController : SHViewController
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHStoryPresentationController *storyCommon;
@property (copy,nonatomic) void (^onIntroComplete)(BOOL isStory);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil
	withOnIntroCompleteAction:(void (^)(BOOL isStory))onIntroComplete;
@end

NS_ASSUME_NONNULL_END
