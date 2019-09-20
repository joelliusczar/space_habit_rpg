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
-(void)setupNormalSectorAndMonster;
@end

NS_ASSUME_NONNULL_END
