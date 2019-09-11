//
//  SHStoryPresentationIntroController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHStoryPresentationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHStoryPresentationIntroController : NSObject
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (weak,nonatomic) UIViewController *central;
@property (strong,nonatomic) SHStoryPresentationController *storyCommon;
/*
	#sectorMonsterQueue
	I'm doing some initial clean up in certain start up situations.
	I don't want the clean up accidently deleting any newly added
	sectors or monsters, so all saving and retrieving actions should
	be done through this queue.
*/
@property (strong,nonatomic) dispatch_queue_t sectorMonsterQueue;
@property (copy,nonatomic) void (^onIntroComplete)(void);
@end

NS_ASSUME_NONNULL_END
