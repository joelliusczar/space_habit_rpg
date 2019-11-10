//
//	SHMonster+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonster.h"
#import "SHModelTools.h"
#import "SHMonsterDictionaryEntry.h"
@import SHCommon;
@import SHData;
@import SHGlobal;

static float MAX_HP_MODIFIER = .1;
static float XP_MODIFIER = .1;
static SHMonsterInfoDictionary *_monsterInfo;

@interface SHMonster ()
@property (readonly,nonatomic) SHMonsterDictionaryEntry *entry;
@end

@implementation SHMonster{
	SHMonsterDictionaryEntry *_entry;
}


+(SHMonsterInfoDictionary *)monsterInfo{
	if(nil == _monsterInfo){
		id<SHResourceUtilityProtocol> resourceUtil = [SHResourceUtility new];
		_monsterInfo = [[SHMonsterInfoDictionary alloc] initWithResourceUtil:resourceUtil];
	}
	return _monsterInfo;
}

+(void)setMonsterInfo:(SHMonsterInfoDictionary *)monsterInfo{
	_monsterInfo = monsterInfo;
}


-(SHMonsterDictionaryEntry*)entry{
	if(nil == _entry){
		_entry = [SHMonster.monsterInfo getMonsterEntry:self.monsterKey];
	}
	return _entry;
}


-(NSString*)fullName{
	return self.entry.fullName;
}


-(NSString *)synopsis{
	return self.entry.synopsis;
}


-(NSString *)headline{
	return self.entry.headline;
}

-(void)copyFrom:(NSObject *)object{
	copyBetween(object, self);
	self.lastUpdateDateTime = [NSDate date];
}


static void copyBetween(NSObject* from,NSObject* to){
	shCopyInstanceVar(from, to, @"lvl");
	shCopyInstanceVar(from, to, @"monsterKey");
	shCopyInstanceVar(from, to, @"nowHp");
}


-(id)valueForUndefinedKey:(NSString *)key{
	(void)key;
	return nil;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
	(void)value;
	(void)key;
}


-(NSMutableDictionary *)mapable{
	return [NSDictionary objectToDictionary:self includeSuperclassProperties:YES];
}


-(BOOL)shouldIgnoreProperty:(NSString *)propName{
	if([propName isEqualToString:@"mapable"]) return YES;
	return NO;
}


-(int32_t)maxHp{
	return self.entry.baseHp + (self.lvl * self.entry.baseHp * MAX_HP_MODIFIER);
}


-(int32_t)attack{
	return self.entry.baseAttack + self.lvl;
}


-(int32_t)defense{
	return self.entry.defense;
}


-(int32_t)xp{
	return self.entry.baseXp + (self.lvl * self.entry.baseXp * XP_MODIFIER);
}


-(float)treasureDropRate{
	return self.entry.treasureDropRate;
}


-(int32_t)encounterWeight{
	return self.entry.encounterWeight;
}


-(SHStoryItemObjectID *)wrappedObjectID{
	SHStoryItemObjectID *wrappedObjectID = [[SHStoryItemObjectID alloc] initWithManagedObject:self];
	return wrappedObjectID;
}

@end
