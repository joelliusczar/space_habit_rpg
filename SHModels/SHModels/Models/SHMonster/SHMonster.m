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
#import "SHMonster_Medium.h"
@import SHCommon;
@import SHData;
@import SHGlobal;

static const float MAX_HP_MODIFIER = .1;
static const float XP_MODIFIER = .1;
static SHMonsterInfoDictionary *_monsterInfo;
static NSString* const BACKEND_KEY = @"monster_data";

@interface SHMonster ()
@property (readonly,nonatomic) SHMonsterDictionaryEntry *entry;
@property (strong, nonatomic) NSMutableDictionary *backend;
@property (strong, nonatomic) NSURL *saveUrl;
@end

@implementation SHMonster{
	SHMonsterDictionaryEntry *_entry;
}


-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [resourceUtil getPListMutableDict:BACKEND_KEY];
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(instancetype)initEmptyWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil {
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [NSMutableDictionary dictionary];
		_resourceUtil = resourceUtil;
	}
	return self;
}


+(SHMonsterInfoDictionary *)monsterInfo{
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
	NSString *headline = [NSString stringWithFormat:self.entry.headline, self.lvl];
	return headline;
}


-(id)valueForUndefinedKey:(NSString *)key{
	(void)key;
	return nil;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
	(void)value;
	(void)key;
}


-(NSDictionary *)mapable{
	return [NSDictionary dictionaryWithDictionary:self.backend];
}


-(NSString*)monsterKey {
	NSString *monsterKey = (NSString*)self.backend[@"monsterKey"];
	return monsterKey;
}


-(void)setMonsterKey:(NSString*)monsterKey {
	self.backend[@"monsterKey"] = monsterKey;
}


-(NSInteger)lvl {
	NSNumber *tmp = (NSNumber*)self.backend[@"lvl"];
	NSInteger lvl = tmp ? tmp.integerValue : 0;
	return lvl;
}


-(void)setLvl:(NSInteger)lvl {
	self.backend[@"lvl"] = @(lvl);
}


-(NSInteger)nowHp {
	NSNumber *tmp = (NSNumber*)self.backend[@"nowHp"];
	NSInteger nowHp = tmp ? tmp.integerValue : 0;
	return nowHp;
}

-(void)setNowHp:(NSInteger)nowHp {
	self.backend[@"nowHp"] = @(nowHp);
}


-(NSInteger)maxHp{
	return self.entry.baseHp + (self.lvl * self.entry.baseHp * MAX_HP_MODIFIER);
}


-(NSInteger)attack{
	return self.entry.baseAttack + self.lvl;
}


-(NSInteger)defense{
	return self.entry.defense;
}


-(NSInteger)xp{
	return self.entry.baseXp + (self.lvl * self.entry.baseXp * XP_MODIFIER);
}


-(float)treasureDropRate{
	return self.entry.treasureDropRate;
}


-(NSInteger)encounterWeight{
	return self.entry.encounterWeight;
}


-(void)saveToFile {
	NSError *error = nil;
	[self.backend writeToURL:self.saveUrl error:&error];
	;
}


-(BOOL)isValid {
	return self.backend != nil;
}


-(void)reload {
	self.backend = [self.resourceUtil getPListMutableDict:BACKEND_KEY];
}

@end
