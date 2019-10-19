//
//	SHMonster_Medium.m
//	SHModels
//
//	Created by Joel Pridgen on 3/25/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHModelTools.h"
#import "SHMonster_Medium.h"


@interface SHMonster_Medium ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHMonsterInfoDictionary* monsterInfo;
@end

@implementation SHMonster_Medium

-(SHMonsterInfoDictionary *)monsterInfo{
	if(nil == _monsterInfo){
		_monsterInfo = SHMonster.monsterInfo;
	}
	return _monsterInfo;
}

-(instancetype)initWithContext:(NSManagedObjectContext*)context{
	if(self = [super init]) {
		_context = context;
	}
	return self;
}

-(SHMonster*)newRandomMonster:(NSString*)sectorKey sectorLvl:(uint32_t)sectorLvl{
	NSAssert(self.context,@"we need that global monster context bro!");
	SHMonster *monster = nil;
	monster = (SHMonster*)[self.context newEntity:SHMonster.entity];
	monster.monsterKey = [self randomMonsterKey:sectorKey];
	monster.lvl = shCalculateLvl(sectorLvl,SH_MONSTER_LVL_RANGE);
	monster.nowHp = monster.maxHp;
	return monster;
}


-(NSString*)randomMonsterKey:(NSString*)sectorKey{
	SHMonsterInfoDictionary *monInfoDict = self.monsterInfo;
	NSMutableArray<NSString *> *monsterKeys = [NSMutableArray arrayWithArray:[monInfoDict getMonsterKeyList:sectorKey]];
	[monsterKeys addObjectsFromArray:[monInfoDict getMonsterKeyList:@"ALL"]];
	SHProbWeight *pbw = [self buildProbilityWeight:monsterKeys];
	return [pbw weightedRandomKey];
}

-(SHProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys{
	SHMonsterInfoDictionary *monInfoDict = self.monsterInfo;
	SHProbWeight *pbw = [[SHProbWeight alloc] init];
	for(NSString* monsterKey in keys){
		SHMonsterDictionaryEntry *entry = [monInfoDict getMonsterEntry:monsterKey];
		int32_t encounterWeight = entry.encounterWeight;
		[pbw add:monsterKey With:encounterWeight];
	}
	return pbw;
}


-(SHMonster*)currentMonster{
	NSAssert(self.context,@"we need that global monster context bro!");
	SHMonster *monster = nil;
	NSFetchRequest<SHMonster *> *request = [SHMonster fetchRequest];
	NSSortDescriptor *sortByMonsterKey = [[NSSortDescriptor alloc]initWithKey:@"monsterKey" ascending:NO];
	request.sortDescriptors = @[sortByMonsterKey];
	NSArray<NSManagedObject *> *results = [self.context getItemsWithRequest:request];
	NSAssert(results.count<2,@"There are too many monsters");
	monster = (SHMonster*)results[0];
	return monster;
}

@end
