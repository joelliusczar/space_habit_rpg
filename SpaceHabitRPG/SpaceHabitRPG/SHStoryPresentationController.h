//
//  SHStoryPresentationController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/SHData.h>
#import <SHModels/SHModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryPresentationController : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) dispatch_queue_t sectorMonsterQueue;
@property (weak,nonatomic) UIViewController *central;
@property (copy,nonatomic) void (^onComplete)(void);
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withSectorMonsterQueue:(dispatch_queue_t)sectorMonsterQueue
	withViewController:(UIViewController*)viewController;
-(void)loadOrSetupHero:(void (^)(void))nextBlock;
-(void)afterSectorPick:(SHSector*)sectorChoice;
-(void)showMonsterStory:(SHMonster*)monster;
@end

NS_ASSUME_NONNULL_END
