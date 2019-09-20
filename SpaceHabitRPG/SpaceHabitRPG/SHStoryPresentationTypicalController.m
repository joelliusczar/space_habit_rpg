//
//  SHStoryPresentationTypicalController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationTypicalController.h"
#import "SHSectorChoiceViewController.h"
#import <SHCommon/NSArray+SHHelper.h>
#import <SHCommon/NSObject+Helper.h>

@implementation SHStoryPresentationTypicalController


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
			self.onPresentComplete();
		}
		//[self prepareScreen];
	}];
}


//#story_logic: normal
-(void)setupNormalSectorAndMonster{
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
