//
//  SHStoryPresentationTypicalController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 9/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryPresentationTypicalController.h"

@implementation SHStoryPresentationTypicalController


//#story_logic: normal
-(void)setupNormalSectorAndMonster{
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	SHSectorInfoDictionary *sectorInfoDict = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context
		withResourceUtil:self.resourceUtil];
	
	[context performBlock:^{
		SHSector *z = [zm getSector:isFront];
	}];

	SHSector * z = [self.storyCommon getCurrentSector];
	if(nil == z){
	//we're not ready yet
		return;
	}
	/*
	Part of me thinks this monster stuff should be abstracted
	to its own method but I'd still have to do this sector
	stuff above and it ends up becoming the same method
	*/
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:context];
	SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:self.resourceUtil];
	SHHeroDTO *heroDTO = self.heroDTO;
	[context performBlock:^{
		SHMonster *m = [mm currentMonster];
		if(m==nil||m.nowHp<1){
			z.monstersKilled = (m && m.nowHp<1)?(z.monstersKilled+1):z.monstersKilled;
		
			if(z.monstersKilled>=z.maxMonsters){
				NSMutableArray<SHSectorDTO *> *sectorChoices = [zm
					newMultipleSectorChoicesGivenHero:heroDTO ifShouldMatchLvl:NO];
			
				[sectorChoices addObject:z];
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					[self showSectorChoiceView:sectorChoices];
				}];
			}
			else { //if we're just using the same sector
				if(m){
					[context deleteObject:m];
				}
				[mm newRandomMonster:z.sectorKey sectorLvl:z.lvl];
				NSError *error = nil;
				[context save:&error];
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					if(error){
						[self showErrorView:@"Save error" withError:error];
						return;
					}
					[self showMonsterStoryWithContext: context];
				}];
			}
		}
		else {
			[[NSOperationQueue mainQueue] addOperationWithBlock:^{
				[self loadOrSetupHero:^{
					[self prepareScreen];
				}];
			}];
		}
	}];
}


@end
