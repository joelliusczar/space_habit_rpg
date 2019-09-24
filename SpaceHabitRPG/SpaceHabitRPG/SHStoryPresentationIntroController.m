//
//  SHStoryPresentationIntroController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationIntroController.h"
#import "SHIntroViewController.h"
#import <SHModels/SHModels.h>
#import <SHControls/UIViewController+Helper.h>


@interface SHStoryPresentationIntroController ()
@property (weak,nonatomic) SHIntroViewController *introVC;

@end

@implementation SHStoryPresentationIntroController


-(SHStoryPresentationController*)storyCommon{
	if(nil == _storyCommon) {
		_storyCommon = [[SHStoryPresentationController alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
			withSectorMonsterQueue:self.sectorMonsterQueue
			withViewController:self.central
			withOnCompleteAction:nil];
	}
	return _storyCommon;
}


-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withViewController:(UIViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>)resourceUtil
	withOnIntroCompleteAction:(void (^)(void))onIntoComplete
{
	if(self = [self init]){
		_context = context;
		_central = viewController;
		_resourceUtil = resourceUtil;
		_onIntroComplete = onIntoComplete;
		_sectorMonsterQueue = dispatch_queue_create("com.SpaceHabit.Sector_Monster",DISPATCH_QUEUE_SERIAL);
	}
	return self;
}


-(void)startIntro{
	[self.context performBlock:^{
		[self cleanUpPreviousAttempts];
		[self showIntroView];
	}];
}

//#story_logic: intro
-(void)cleanUpPreviousAttempts{
	
	NSManagedObjectContext *context = self.context;
	//see note by sectorMonsterQueue #sectorMonsterQueue
	dispatch_sync(self.sectorMonsterQueue,^{
		//don't add any other entities than sector and monster
		NSFetchRequest *sectorsRequest = SHSector.fetchRequest;
		NSFetchRequest *monstersRequest = SHMonster.fetchRequest;
		NSBatchDeleteRequest *deleteSectors = [[NSBatchDeleteRequest alloc] initWithFetchRequest:sectorsRequest];
		deleteSectors.resultType = NSBatchDeleteResultTypeCount;
		NSBatchDeleteRequest *deleteMonsters = [[NSBatchDeleteRequest alloc] initWithFetchRequest:monstersRequest];
		deleteMonsters.resultType = NSBatchDeleteResultTypeCount;
		[context performBlockAndWait:^{
			@autoreleasepool {
				NSError *errorSectors = nil;
				NSBatchDeleteResult *sectorResults = [context executeRequest:deleteSectors error:&errorSectors];
				NSError *errorMonsters = nil;
				NSBatchDeleteResult *monsterResults = [context executeRequest:deleteMonsters error:&errorMonsters];
				[context performBlock:^{
					NSInteger sectorCounts = ((NSNumber*)sectorResults.result).integerValue;
					if(sectorCounts > 0){
						SHTransaction_Medium *sm = [[SHTransaction_Medium alloc] initWithContext:context
							andEntityType:SHSector.entity.name];
						[sm addBatchDeleteTransaction:[NSString stringWithFormat:
							@"Batch deleted %ldl sectors",sectorCounts]];
					}
					NSInteger monsterCounts = ((NSNumber*)monsterResults.result).integerValue;
					if(monsterCounts > 0){
						SHTransaction_Medium *mm = [[SHTransaction_Medium alloc] initWithContext:context
							andEntityType:SHMonster.entity.name];
						[mm addBatchDeleteTransaction:[NSString stringWithFormat:
							@"Batch deleted %ldl monsters",monsterCounts]];
					}
				}];
			}
		}];
		
	});
}


// logic picks back up in afterIntroStarted
//#story_logic: intro
-(void)showIntroView{

	__weak typeof(self) weakSelf = self;
	self.storyCommon.onComplete = ^{
		typeof(weakSelf) bSelf = weakSelf;
		if(nil == bSelf) return;
		if(nil != bSelf.introVC){
			[bSelf.introVC popVCFromFront];
		}
		[bSelf afterIntroCompleted];
	};
	SHIntroViewController *introVC = [[SHIntroViewController alloc] initWithSkipAction:^{
		[self.context performBlock:^{
			SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
			SHConfig *config = [cm globalConfig];
			config.storyMode = SH_STORY_MODE_NO_MONSTERS;
			NSError *error = nil;
			[self.context save:&error];
			if(error) {
				@throw [NSException dbException:error];
			}
			[self afterIntroCompleted];
		}];
	} withOnNextAction:^{
		[self.context performBlock:^{
			SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
			SHConfig *config = [cm globalConfig];
			config.storyMode = SH_STORY_MODE_FULL;
			NSError *error = nil;
			[self.context save:&error];
			if(error) {
				@throw [NSException dbException:error];
			}
			[self afterIntroStarted];
		}];
	}];
	[self.central arrangeAndPushChildVCToFront:introVC];
	self.introVC = introVC;
}


/*
	This is where the logic picks back up after the intro view
*/
//#story_logic: intro
-(void)afterIntroStarted{
	/*
			This whole process is hard to follow.
			It's because there's a few steps are dependent upon user input.
			So, the choices were:
			A. Have a convoluted state machine that goes down different
				branches depending on if certain conditions were met yet.
			B. (What I'm currently doing) Basically, callback hell. This way
				I can connect the next actions to the end of the previous
				segment.
			I suppose I could have also writen my modals work like showDialog
				in winforms. But I'm not doing that.
	 
	*/
	
	
	[self.storyCommon loadOrSetupHero:^{
		//perform block is good here because loadOrSetupHero runs this callback on main thread
		[self.context performBlock:^{
			NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
			SHSector_Medium *sm = [SHSector_Medium newWithContext:self.context
				withResourceUtil:resourceUtil];
			SHSector *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
			[self.storyCommon afterSectorPick:s];
		}];
	}];
}


//#story_logic: intro
-(void)afterIntroCompleted{
	[self.context performBlock:^{
		SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
		SHConfig *config = [cm globalConfig];
		if(config.gameState == SH_GAME_STATE_UNINITIALIZED) {
			config.gameState = SH_GAME_STATE_INITIALIZED;
			NSError *error = nil;
			[self.context save:&error];
			if(error){
				@throw [NSException dbException:error];
			}
		}
	}];
	if(self.onIntroComplete){
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.onIntroComplete();
		}];
	}
}

@end
