//
//  SHStoryPresentationTypicalController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationTypicalController.h"
#import "SHSectorChoiceViewController.h"
@import SHCommon;

@implementation SHStoryPresentationTypicalController


-(SHStoryPresentationController*)storyCommon{
	if(nil == _storyCommon){
		_storyCommon = [[SHStoryPresentationController alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
			withSectorMonsterQueue:self.sectorMonsterQueue
			withViewController:self.central];
	}
	return _storyCommon;
}


-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withDataController:(id<P_CoreData>)dataController
	withViewController:(UIViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withOnPresentComplete:(void (^)(void))onPresentComplete
{
	if(self = [self init]){
		_context = context;
		_dataController = dataController;
		_central = viewController;
		_resourceUtil = resourceUtil;
		_onPresentComplete = onPresentComplete;
		_sectorMonsterQueue = dispatch_queue_create("com.SpaceHabit.Sector_Monster",DISPATCH_QUEUE_SERIAL);
	}
	return self;
}


-(void)needsNewMonster:(SHSector*)sector{
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:self.context];
	SHMonster *monster = [mm newRandomMonster:sector.sectorKey sectorLvl:sector.lvl];
	NSError *error = nil;
	[self.context save:&error];
	if(error){
		@throw [NSException dbException:error];
	}
	[self.storyCommon showMonsterStory:monster];
}


-(void)needsNewZone{
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	[context performBlock:^{
		SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:self.resourceUtil];
		SHHero_Medium *hm = [[SHHero_Medium alloc] initWithContext:context];
		SHHero *hero = [hm hero];
		NSArray<SHSector*> *sectors = [zm newMultipleSectorChoicesGivenHero:hero ifShouldMatchLvl:NO];
		NSArray<SHStoryItemObjectID*> *objectIDs = [sectors mapItemsTo:^ id (id sector,NSUInteger idx){
			(void)idx;
			SHSector *sectorCast = (SHSector*)sector;
			SHStoryItemObjectID *objectID = [[SHStoryItemObjectID alloc] initWithManagedObject:sectorCast];
			return objectID;
		}];
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			SHSectorChoiceViewController *sectorChoiceView = [[SHSectorChoiceViewController alloc]
				initWithSectorIDs:objectIDs
				withOnSelectionAction:^(SHStoryItemObjectID *storyObjectID){
					NSManagedObjectContext *context = storyObjectID.context;
					[context performBlock:^{
						NSError *error = nil;
						SHSector *tmpSector = (SHSector*)[context getEntityOrNil:storyObjectID withError:&error];
						if(error) {
							@throw [NSException dbException:error];
						}
						[self.context performBlock:^{
							SHSector *sector = (SHSector*)[context newEntity:SHSector.entity];
							[sector narrowCopyFrom:tmpSector];
							[self needsNewMonster:sector];
						}];
					}];
				}];
	
			[self.central.view addSubview:sectorChoiceView.view];
			[self.central addChildViewController:sectorChoiceView];
			[sectorChoiceView didMoveToParentViewController:self.central];
		}];
	}];
}


-(void)finishPresent{
	[self.storyCommon loadOrSetupHero:^{
		if(self.onPresentComplete){
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				self.onPresentComplete();
			}];
		}
	}];
}

-(void)setupNormalSectorAndMonster{
	[self.context performBlock:^{
		[self _setupNormalSectorAndMonster];
	}];
}


//#story_logic: normal
-(void)_setupNormalSectorAndMonster{
	BOOL isFront = YES;
	NSManagedObjectContext *context = self.context;
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context
		withResourceUtil:self.resourceUtil];
	SHSector *z = [zm getSector:isFront];
	if(z) {
		SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:context];
		SHMonster *m = [mm currentMonster];
		if(m && m.nowHp > 0) {
			[self finishPresent];
			return;
		}
		z.monstersKilled = (m && m.nowHp < 1) ? (z.monstersKilled + 1) : z.monstersKilled;
		if(m){
			[context deleteObject:m];
		}
		if(z.monstersKilled >= z.maxMonsters) {
			[self needsNewZone];
		}
		else {
			[self needsNewMonster:z];
		}
	}
	else {
		[self needsNewZone];
	}
}


@end
