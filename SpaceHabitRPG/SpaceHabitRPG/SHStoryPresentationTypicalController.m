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
@import SHModels;

@implementation SHStoryPresentationTypicalController


-(SHStoryPresentationController*)storyCommon{
	if(nil == _storyCommon){
		_storyCommon = [[SHStoryPresentationController alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
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
	}
	return self;
}


-(void)needsNewMonster:(SHSector*)sector{
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHMonster *monster = [mm newRandomMonster:sector.sectorKey sectorLvl:sector.lvl];
	NSError *error = nil;
	[self.context save:&error];
	if(error){
		@throw [NSException dbException:error];
	}
	[self.storyCommon showMonsterStory:monster];
}


-(void)needsNewZone{
	SHSector_Medium *zm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHHero *hero = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
	NSArray<SHSector*> *sectors = [zm newMultipleSectorChoicesGivenHero:hero ifShouldMatchLvl:NO];
	SHSectorChoiceViewController *sectorChoiceView = [[SHSectorChoiceViewController alloc]
		initWithSectors:sectors
		withOnSelectionAction:^(SHSector *sector){
					[self needsNewMonster:sector];
		}];

	[self.central.view addSubview:sectorChoiceView.view];
	[self.central addChildViewController:sectorChoiceView];
	[sectorChoiceView didMoveToParentViewController:self.central];
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
	SHSector *z = [[SHSector alloc] initWithResourceUtil:self.resourceUtil];
	if(z) {
		SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
		SHMonster *m = [mm currentMonster];
		if(m && m.nowHp > 0) {
			[self finishPresent];
			return;
		}
		z.monstersKilled = (m && m.nowHp < 1) ? (z.monstersKilled + 1) : z.monstersKilled;
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
