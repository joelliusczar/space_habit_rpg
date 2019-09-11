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
-(void)loadOrSetupHero:(void (^)(void))nextBlock;
-(void)afterSectorPick:(SHSector*)sectorChoice;
@end

NS_ASSUME_NONNULL_END
