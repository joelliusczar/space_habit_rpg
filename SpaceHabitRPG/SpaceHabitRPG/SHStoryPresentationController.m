//
//  SHStoryPresentationController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationController.h"
#import <SHModels/SHModels.h>

@implementation SHStoryPresentationController


//#story_logic: both
-(void)loadOrSetupHero:(void (^)(void))nextBlock{
	NSManagedObjectContext *context = self.context;
	//what the hell, we're doing it async everywhere else in this
	//file, why not here too.
	[context performBlock:^{
		NSFetchRequest *heroRequest = SHHero.fetchRequest;
		NSSortDescriptor *sortBy = [NSSortDescriptor
			sortDescriptorWithKey:@"lvl"
			ascending:YES];
		heroRequest.sortDescriptors = @[sortBy];
		NSError *error = nil;
		NSArray *results = [context executeFetchRequest:heroRequest error:&error];
		if(error){
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[self showErrorView:@"Retriving hero failed"
					withError:error];
			}];
			return;
		}
		SHHero *heroCD = nil;
		if(results.count > 0){
			heroCD = (SHHero*)results[0];
		}
		else{
			heroCD = (SHHero*)[context newEntity:SHHero.entity];
			NSError *saveError = nil;
			[context save:&saveError];
			if(saveError){
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					[self showErrorView:@"Saving hero failed"
						withError:error];
				}];
				return;
			}
		}
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			nextBlock();
		}];
	}];
}


	//#story_logic: both
-(void)afterSectorPick:(SHSector*)sectorChoice{

	NSManagedObjectContext *context = self.context;
	NSObject<SHResourceUtilityProtocol> *resourceUtil = self.resourceUtil;
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil];
	SH
	if(sectorChoice==nil){
		//my theory is that I am copying heroDTO b/c it belongs to the main thread
		SHHeroDTO *heroCopy = [self.heroDTO copy];
		sectorChoice = [zm newRandomSectorChoiceGivenHero:heroCopy
			ifShouldMatchLvl:NO];
	}
	SHSector *sectorCD = (SHSector*)[context newEntity:SHSector.entity];
	[sectorCD copyFrom:sectorChoice];
	//see note by sectorMonsterQueue #sectorMonsterQueue
	dispatch_sync(self.sectorMonsterQueue, ^{
		[zm moveSectorToFront:sectorCD];
	});
	sectorChoice.objectID = sectorCD.objectID;
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		self.sectorDTO = sectorChoice;
	}];
	
	SHTransaction_Medium *zt = [[SHTransaction_Medium alloc]
		initWithContext:context andEntityType:SHSector.entity.name];

	[zt addCreateTransaction:sectorChoice.mapable];
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[self showSectorStoryWithContext:context];
	}];
}


-(void)showStoryItem:(SHObjectIDWrapper*)storyItemObjectID
	withResponse:(void (^)(SHStoryDumpView * nullable))response
{
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	[context performBlock:^{
		SHConfigDTO *config = self.configDTO;
		if(config.storyModeisOn){
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				SHStoryDumpView *sdv = [[SHStoryDumpView alloc] initWithStoryItemObjectID:storyItemObjectID];
				sdv.responseBlock = response;
				sdv.backgroundColor = UIColor.whiteColor;
				[self arrangeAndPushChildVCToFront:sdv];
			}];
		}
		else{
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				@autoreleasepool {
					response(nil);
				}
			}];
			
		}
	}];
}

//#story_logic: both
-(void)showMonsterStoryWithContext:(NSManagedObjectContext*)context{
	[self showStoryItem:self.monsterEntry withResponse:^(SHStoryDumpView * sdv){
		(void)sdv;
		if(nil != self.introVC){
			[self.introVC popVCFromFront];
		}
		[self afterIntroCompleted:context];
	}];
}

//#story_logic: both
-(void)showSectorStoryWithContext:(NSManagedObjectContext*)context{
	[self showStoryItem:self.sectorDTO withResponse:^(SHStoryDumpView * sdv){
		(void)sdv;
		SHSectorDTO *sectorDTO = self.sectorDTO;
		[context performBlock:^{
			SHTransaction_Medium *mt = [[SHTransaction_Medium alloc] initWithContext:context
				andEntityType:SHMonster.entity.name];
			SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:context];
			SHMonster *monsterCD = [mm newRandomMonster:sectorDTO.sectorKey sectorLvl:sectorDTO.lvl];
			[mt addCreateTransaction:monsterCD.mapable];
			NSError *error = nil;
			[context save: &error];
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				if(error){
					[self showErrorView:@"Save error" withError:error];
					return;
				}
				[self showMonsterStoryWithContext:context];
			}];
		}];
	}];
}


-(SHSector *)getCurrentSector{
	BOOL isFront = YES;
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	SHSectorInfoDictionary *sectorInfoDict = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context
		withResourceUtil:self.resourceUtil];
	__block SHSectorDTO *result = nil;
	[context performBlockAndWait:^{
		@autoreleasepool {
			SHSector *z = [zm getSector:isFront];
			if(z==nil){
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					NSMutableArray<SHSectorDTO*> *sectorChoices = [zm
					newMultipleSectorChoicesGivenHero:self.heroDTO ifShouldMatchLvl:NO];
			
					[self showSectorChoiceView:sectorChoices];
				}];
			}
			else{
				result = [SHSectorDTO newWithSectorDict:sectorInfoDict];
				[result dtoCopyFrom:z];
			}
		}
	}];
	return result;
}


//#story_logic: normal
-(void)showSectorChoiceView:(NSArray<SHSector *> *)sectorChoices
	withOnSelectionBlock:(void (^)(void))onSelectionBlock
{
	SHSectorChoiceViewController *sectorChoiceView = [SHSectorChoiceViewController
		newWithCentral:self AndSectorChoices:sectorChoices];
	
	[self.view addSubview:sectorChoiceView.view];
	[self addChildViewController:sectorChoiceView];
	[sectorChoiceView didMoveToParentViewController:self];
}

@end
