//
//  SHStoryRouter.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryRouterHelper.h"
@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryRouter : NSObject
@property (strong,nonatomic) SHStoryRouterHelper *storyHelper;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (weak,nonatomic) SHViewController *central;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (copy,nonatomic) void (^onPresentComplete)(void);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withViewController:(SHViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withOnPresentComplete:(void (^)(void))onPresentComplete;
-(void)setupNormalSectorAndMonster;
-(void)showStoryForHomeSector;
@end

NS_ASSUME_NONNULL_END
