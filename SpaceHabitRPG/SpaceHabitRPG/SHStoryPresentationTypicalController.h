//
//  SHStoryPresentationTypicalController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHStoryPresentationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryPresentationTypicalController : NSObject
@property (strong,nonatomic) SHStoryPresentationController *storyCommon;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) id<P_CoreData> dataController;
@property (weak,nonatomic) UIViewController *central;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (copy,nonatomic) void (^onPresentComplete)(void);
@property (strong,nonatomic) dispatch_queue_t sectorMonsterQueue;
-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withDataController:(id<P_CoreData>)dataController
	withViewController:(UIViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withOnPresentComplete:(void (^)(void))onPresentComplete;
-(void)setupNormalSectorAndMonster;
@end

NS_ASSUME_NONNULL_END
