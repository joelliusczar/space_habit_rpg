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



@interface SHStoryPresentationIntroController ()
@property (weak,nonatomic) SHIntroViewController *introVC;

@end

@implementation SHStoryPresentationIntroController

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
	/*Since self.introVC is a weak ref, we must create this local var
	to hold the value until the strong ref gets attached.
	I made self.introVC a weak because I only want a reference to it
	if it actually exists. I don't want to actively keep it alive, which
	is what a strong ref would do.
	*/
	SHIntroViewController *introVC = [[SHIntroViewController alloc] initWithSkipAction:^{
		[self.context performBlock:^{
			SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
			SHConfig *config = [cm globalConfig];
			config.storyModeisOn = NO;
			NSError *error = nil;
			[self.context save:&error];
			if(error) {
				@throw [NSException dbException:error];
			}
		}];
	} withOnNextAction:^{
		[self.context performBlock:^{
			SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
			SHConfig *config = [cm globalConfig];
			config.storyModeisOn = YES;
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
		NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
		SHSector_Medium *sm = [SHSector_Medium newWithContext:nil
			withResourceUtil:resourceUtil];
		SHSector *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
		[self.storyCommon afterSectorPick:s];
	}];
}


//#story_logic: intro
-(void)afterIntroCompleted:(NSManagedObjectContext*)context{
	[self.context performBlock:^{
		SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
		SHConfig *config = [cm globalConfig];
		if(config.gameState == SH_GAME_STATE_UNINITIALIZED){
			config.gameState = SH_GAME_STATE_INITIALIZED;
			NSError *error = nil;
			[context save:&error];
			if(nil == error){
				self.configDTO = dto;
			}
			else{
				@throw [NSException dbException:error];
			}
		}
	}];
	if(self.onIntroComplete){
		self.onIntroComplete();
	}
}

@end
