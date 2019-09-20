//
//  SHStoryPresentationController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationController.h"
#import <SHModels/SHModels.h>
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHControls/UIViewController+Helper.h>
#import "SHStoryDumpView.h"


@interface SHStoryPresentationController ()
@property (strong,nonatomic) SHConfig *config;
@end

@implementation SHStoryPresentationController


-(SHConfig*)config{
	if(nil == _config){
		SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
		_config = [cm globalConfig];
	}
	return _config;
}


//#story_logic: both
-(void)loadOrSetupHero:(void (^)(void))nextBlock{
	NSManagedObjectContext *context = self.context;

	[context performBlock:^{
		SHHero_Medium *hm = [[SHHero_Medium alloc] initWithContext:context];
		[hm hero];
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			nextBlock();
		}];
	}];
}


	//#story_logic: both
-(void)afterSectorPick:(SHSector*)sector{

	NSManagedObjectContext *context = self.context;
	NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil];
	dispatch_sync(self.sectorMonsterQueue, ^{
		[zm moveSectorToFront:sector];
	});
	
	SHTransaction_Medium *zt = [[SHTransaction_Medium alloc]
		initWithContext:context andEntityType:SHSector.entity.name];

	[zt addCreateTransaction:sector.mapable];
	[self showSectorStory: sector];
}


-(void)showStoryItem:(id<SHStoryItemProtocol>)storyItem
	withResponse:(void (^)(SHStoryDumpView * nullable))response
{
	if(self.config.storyMode == SH_STORY_MODE_FULL){
		SHStoryItemObjectID *objectID = storyItem.wrappedObjectID;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			SHStoryDumpView *sdv = [[SHStoryDumpView alloc] initWithStoryItemObjectID:objectID];
			sdv.responseBlock = response;
			sdv.backgroundColor = UIColor.whiteColor;
			[self.central arrangeAndPushChildVCToFront:sdv];
		}];
	}
	else {
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			@autoreleasepool {
				response(nil);
			}
		}];
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

//#story_logic: both
-(void)showSectorStory:(SHSector *)sector{
	[self showStoryItem:sector withResponse:^(SHStoryDumpView * sdv){
		(void)sdv;
		[self.context performBlock:^{
			SHTransaction_Medium *mt = [[SHTransaction_Medium alloc] initWithContext:self.context
				andEntityType:SHMonster.entity.name];
			SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:self.context];
			SHMonster *monster = [mm newRandomMonster:sector.sectorKey sectorLvl:sector.lvl];
			[mt addCreateTransaction:monster.mapable];
			NSError *error = nil;
			[self.context save: &error];
			if(error){
				@throw [NSException dbException:error];
			}
			[self showMonsterStory:monster];
		}];
	}];
}


@end
