//
//  SHPostIntroPresenter.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHStoryPresentationController.h"
@import CoreData;
@import SHCommon;

NS_ASSUME_NONNULL_BEGIN

@interface SHPostIntroPresenter : NSObject
@property (weak, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHStoryPresentationController *storyCommon;
@property (copy,nonatomic) void (^onIntroComplete)(BOOL isStory);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withViewController:(UIViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil
	withOnIntroCompleteAction:(void (^)(BOOL isStory))onIntroComplete;
	
-(void)runPostIntroSequence;
@end

NS_ASSUME_NONNULL_END
