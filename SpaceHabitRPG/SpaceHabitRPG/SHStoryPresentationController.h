//
//  SHStoryPresentationController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHData;
@import SHModels;

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryPresentationController : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (weak,nonatomic) UIViewController *central;
@property (copy,nonatomic) void (^onComplete)(void);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withViewController:(UIViewController*)viewController;
-(void)loadOrSetupHero:(void (^)(void))nextBlock;
-(void)showMonsterStory:(SHMonster*)monster;
-(void)showSectorStory:(SHSector *)sector;
@end

NS_ASSUME_NONNULL_END
