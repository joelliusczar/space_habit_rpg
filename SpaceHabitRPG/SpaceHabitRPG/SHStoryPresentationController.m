//
//  SHStoryPresentationController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationController.h"
#import "SHStoryDumpView.h"
@import SHCommon;
@import SHModels;
@import SHControls;


@interface SHStoryPresentationController ()
@end

@implementation SHStoryPresentationController



-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withViewController:(UIViewController*)viewController
{
	if(self = [self init]){
		_context = context;
		_resourceUtil = resourceUtil;
		_central = viewController;
	}
	return self;
}


//#story_logic: both
-(void)loadOrSetupHero:(void (^)(void))nextBlock{
	nextBlock();
}


-(void)showStoryItem:(NSObject<SHStoryItemProtocol>*)storyItem
	withResponse:(void (^)(SHStoryDumpView * nullable))response
{
	SHConfig *config = [[SHConfig alloc] init];
	if(config.storyMode == SH_STORY_MODE_FULL){
		SHStoryDumpView *sdv = [[SHStoryDumpView alloc] initWithStoryItemObject:storyItem];
		sdv.responseBlock = response;
		sdv.backgroundColor = UIColor.whiteColor;
		[self.central arrangeAndPushChildVCToFront:sdv];
	}
	else {
		response(nil);
	}
}

//#story_logic: both
-(void)showMonsterStory:(SHMonster*)monster{
	[self showStoryItem:monster withResponse:^(SHStoryDumpView * sdv){
		(void)sdv;
		if(self.onComplete){
			self.onComplete();
		}
	}];
}


-(void)showSectorStory:(SHSector *)sector {
	[self.context performBlock:^{
		SHTransaction_Medium *st = [[SHTransaction_Medium alloc]
			initWithContext:self.context andEntityType:@"SHSector"];

		[st addCreateTransaction:sector.mapable];
	}];
	
	[self showStoryItem:sector withResponse:^(SHStoryDumpView * sdv){
		(void)sdv;
		[self.context performBlock:^{
			SHTransaction_Medium *mt = [[SHTransaction_Medium alloc] initWithContext:self.context
				andEntityType:@"SHMonster"];
			SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
			SHMonster *monster = [mm newRandomMonster:sector.sectorKey sectorLvl:sector.lvl];
			[self.context performBlock:^{
				[mt addCreateTransaction:monster.mapable];
				NSError *error = nil;
				[self.context save: &error];
				if(error){
					@throw [NSException dbException:error];
				}
			}];
			
			[self showMonsterStory:monster];
		}];
	}];
}


@end
