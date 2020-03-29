//
//  SHStoryRouter.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryRouter.h"
#import "SHSectorChoiceViewController.h"
@import SHCommon;
@import SHModels;

@implementation SHStoryRouter


-(SHStoryRouterHelper*)storyHelper{
	if(nil == _storyHelper){
		_storyHelper = [[SHStoryRouterHelper alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
			withViewController:self.central];
			_storyHelper.onComplete = self.onPresentComplete;
	}
	return _storyHelper;
}


-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withViewController:(SHViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
	withOnPresentComplete:(void (^)(void))onPresentComplete
{
	if(self = [self init]){
		_context = context;
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
	[self.storyHelper showMonsterStory:monster];
}


- (void)showSectorChoices:(NSArray<SHSector *> *)sectors {
	SHSectorChoiceViewController *sectorChoiceView = [[SHSectorChoiceViewController alloc]
		initWithSectors:sectors
		withOnSelectionAction:^(SHSector *sector){
			SHSector_Medium *zm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
			[zm eraseSectorChoices];
			[self needsNewMonster:sector];
	}];
	[self.central arrangeAndPushChildVCToFront:sectorChoiceView];
}

-(void)needsNewZone{
	SHSector_Medium *zm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHHero *hero = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
	NSArray<SHSector*> *sectors = [zm newMultipleSectorChoicesGivenHero:hero ifShouldMatchLvl:NO];
	SHConfig *config = [[SHConfig alloc] init];
	config.storyState = SH_STORY_STATE_SECTOR_CHOICE_WAITING;
	[self showSectorChoices:sectors];
}


-(void)finishPresent{
	if(self.onPresentComplete){
		self.onPresentComplete();
	}
}


-(void)showStoryForHomeSector {
	SHSector_Medium *sm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHSector *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
	[s saveToFile];
	SHConfig *config = [[SHConfig alloc] init];
	config.storyMode = SH_STORY_MODE_FULL;
	config.gameState = SH_GAME_STATE_INTRO_FINISHED_INITIAL_STORY;
	[self.storyHelper addSectorTransaction:s];
	[self.storyHelper showSectorStory:s];
}


-(void)continueFromInteruption:(SHStoryState)storyState {
	if(storyState == SH_STORY_STATE_SECTOR_CHOICE_WAITING) {
		SHSector_Medium *zm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
		NSArray<SHSector*> *sectors = [zm getUndecidedSectorChoices];
		[self showSectorChoices:sectors];
	}
	else if(storyState == SH_STORY_STATE_SECTOR_WAITING) {
		SHSector *sector = [[SHSector alloc] initWithResourceUtil:self.resourceUtil];
		[self.storyHelper showSectorStory:sector];
	}
	else if(storyState == SH_STORY_STATE_MONSTER_WAITING) {
		SHMonster *monster = [[SHMonster alloc] initWithResourceUtil:self.resourceUtil];
		[self.storyHelper showMonsterStory:monster];
	}
}


-(void)setupNormalSectorAndMonster{
	SHConfig *config = [[SHConfig alloc] init];
	if(config.storyState != SH_STORY_STATE_NORMAL) {
		[self continueFromInteruption: config.storyState];
		return;
	}
	SHSector *z = [[SHSector alloc] initWithResourceUtil:self.resourceUtil];
	if([z isValid]) {
		SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
		SHMonster *m = [mm currentMonster];
		if([m isValid] && m.nowHp > 0) {
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
