//
//	SHMonster+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonster.h"
#import <SHCommon/SHCommonUtils.h>
#import "SHModelTools.h"
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHCollectionUtils.h>
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHCommon/SHResourceUtility.h>

static float MAX_HP_MODIFIER = .1;
static SHMonsterInfoDictionary *_monsterInfo;

@implementation SHMonster


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
	return [NSDictionary objectToDictionary:self
		withTransformer:shDefaultTransformer
		withSet:nil];
}


-(BOOL)shouldIgnoreProperty:(NSString *)propName{
	if([propName isEqualToString:@"mapable"]) return YES;
	return NO;
}


-(int32_t)maxHp{
	SHMonsterDictionaryEntry *entry = [SHMonster.monsterInfo getMonsterEntry:self.monsterKey];
	return entry.baseHp + (self.lvl * entry.baseHp * MAX_HP_MODIFIER);
}


-(int32_t)attack{
	SHMonsterDictionaryEntry *entry = [SHMonster.monsterInfo getMonsterEntry:self.monsterKey];
	return entry.baseAttack + self.lvl;
}

@end
