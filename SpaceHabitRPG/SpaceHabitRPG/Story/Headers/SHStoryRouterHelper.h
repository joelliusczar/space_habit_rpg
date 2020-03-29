//
//  SHStoryRouterHelper.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHModels;
@import SHControls;

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryRouterHelper : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (weak,nonatomic) SHViewController *central;
@property (copy,nonatomic) void (^onComplete)(void);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withViewController:(SHViewController*)viewController;
-(void)showMonsterStory:(SHMonster*)monster;
-(void)showSectorStory:(SHSector *)sector;
-(void)addSectorTransaction:(SHSector *)sector;
@end

NS_ASSUME_NONNULL_END
