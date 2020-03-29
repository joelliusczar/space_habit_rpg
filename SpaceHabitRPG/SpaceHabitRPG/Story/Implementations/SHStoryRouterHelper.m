//
//  SHStoryRouterHelper.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryRouterHelper.h"
#import "SHStoryDumpViewController.h"
@import SHCommon;
@import SHModels;
@import SHControls;


@interface SHStoryRouterHelper ()
@end

@implementation SHStoryRouterHelper



-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withViewController:(SHViewController*)viewController
{
	if(self = [self init]){
		_context = context;
		_resourceUtil = resourceUtil;
		_central = viewController;
	}
	return self;
}


-(void)showStoryItem:(NSObject<SHStoryItemProtocol>*)storyItem
	withResponse:(void (^)(SHStoryDumpViewController * nullable))response
{
	SHConfig *config = [[SHConfig alloc] init];
	if(config.storyMode == SH_STORY_MODE_FULL){
		SHStoryDumpViewController *sdv = [[SHStoryDumpViewController alloc] init];
		sdv.storyItemObject = storyItem;
		sdv.responseBlock = response; //gets called further down the line
		SHTransparentModalViewController *modal = [[SHTransparentModalViewController alloc]
			initWithModalViewController:sdv];
		[self.central arrangeAndPushChildVCToFront:modal];
	}
	else {
		response(nil);
	}
}


-(void)showMonsterStory:(SHMonster*)monster{
	[self showStoryItem:monster withResponse:^(SHStoryDumpViewController * sdv){
		(void)sdv;
		SHConfig *config = [[SHConfig alloc] init];
		config.storyState = SH_STORY_STATE_NORMAL;
		if(config.gameState == SH_GAME_STATE_INTRO_FINISHED_INITIAL_STORY) {
			config.gameState = SH_GAME_STATE_INITIALIZED;
		}
		if(self.onComplete){
			self.onComplete();
		}
	}];
}


-(void)addSectorTransaction:(SHSector *)sector {
	[self.context performBlock:^{
		SHTransaction_Medium *st = [[SHTransaction_Medium alloc]
			initWithContext:self.context andEntityType:@"SHSector"];
		
		[st addCreateTransaction:sector.mapable];
	}];
}


-(void)addMonsterTransaction:(SHMonster *)monster {
	SHTransaction_Medium *mt = [[SHTransaction_Medium alloc] initWithContext:self.context
		andEntityType:@"SHMonster"];
	[self.context performBlock:^{
		[mt addCreateTransaction:monster.mapable];
		NSError *error = nil;
		[self.context save: &error];
		if(error){
			@throw [NSException dbException:error];
		}
	}];
}


-(void)showSectorStory:(SHSector *)sector {
	SHConfig *config = [[SHConfig alloc] init];
	config.storyState = SH_STORY_STATE_SECTOR_WAITING;
	[self showStoryItem:sector withResponse:^(SHStoryDumpViewController * sdv){
		(void)sdv;
		SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
		SHMonster *monster = [mm newRandomMonster:sector.sectorKey sectorLvl:sector.lvl];
		[monster saveToFile];
		[self addMonsterTransaction:monster];
		config.storyState = SH_STORY_STATE_MONSTER_WAITING;
		[self showMonsterStory:monster];
	}];
}


@end
