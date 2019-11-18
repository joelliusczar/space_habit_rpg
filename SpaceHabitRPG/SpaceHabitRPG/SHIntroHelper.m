//
//  SHIntroHelper.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/15/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHIntroHelper.h"


@implementation SHIntroHelper


-(instancetype)initWithContext:(NSManagedObjectContext*)context{
	if(self = [super init]){
		_context = context;
	}
	return self;
}


-(void)cleanUpPreviousAttempts{
	
	NSManagedObjectContext *context = self.context;
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
				if(sectorCounts > 0) {
					SHTransaction_Medium *sm = [[SHTransaction_Medium alloc] initWithContext:context
						andEntityType:SHSector.entity.name];
					[sm addBatchDeleteTransaction:[NSString stringWithFormat:
						@"Batch deleted %ldl sectors",sectorCounts]];
				}
				NSInteger monsterCounts = ((NSNumber*)monsterResults.result).integerValue;
				if(monsterCounts > 0) {
					SHTransaction_Medium *mm = [[SHTransaction_Medium alloc] initWithContext:context
						andEntityType:SHMonster.entity.name];
					[mm addBatchDeleteTransaction:[NSString stringWithFormat:
						@"Batch deleted %ldl monsters",monsterCounts]];
				}
			}];
		}
	}];
}


-(void)afterIntroCompleted{
	SHConfig *config = [[SHConfig alloc] init];
	if(config.gameState == SH_GAME_STATE_UNINITIALIZED) {
		config.gameState = SH_GAME_STATE_INTRO_FINISHED;
	}
}

@end
