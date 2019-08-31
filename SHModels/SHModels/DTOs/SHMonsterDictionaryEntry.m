//
//	SHMonsterDictionaryEntry.m
//	SHModels
//
//	Created by Joel Pridgen on 4/6/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHMonsterDictionaryEntry.h"
#import <SHCommon/NSObject+Helper.h>
#import <SHCommon/SHCollectionUtils.h>
#import <SHCommon/NSDictionary+SHHelper.h>

@implementation SHMonsterDictionaryEntry


-(instancetype)initWith:(NSString*)monsterKey withMonsterDict:(SHMonsterInfoDictionary*)monInfoDict{
	if(self = [super init]){
		_monsterKey = monsterKey;
		_monInfoDict = monInfoDict;
	}
	return self;
}


-(NSString *)fullName{
	NSString *name = [self.monInfoDict getName:self.monsterKey];
	return name;
}

-(NSString *)synopsis{
	return [self.monInfoDict getDescription:self.monsterKey];
}

-(NSString *)headline{
	NSString *grammaticalAgreement = [self.monInfoDict getGrammaticalAgreement:self.monsterKey];
	if([grammaticalAgreement isEqualToString:@"SC"]){
		return [NSString stringWithFormat:@"Your ship encountered a \n%@!",self.fullName];
	}
	if([grammaticalAgreement isEqualToString:@"SV"]){
		return [NSString stringWithFormat:@"Your ship encountered an \n%@!",self.fullName];
	}
	if([grammaticalAgreement isEqualToString:@"PL"]){
		return [NSString stringWithFormat:@"Your ship encountered some \n%@!",self.fullName];
	}
	@throw [NSException exceptionWithName:@"Invalid gramatical agreement" reason:[NSString stringWithFormat:@"The culprit was %@",self.fullName]userInfo:nil];
}

-(int32_t)baseAttack{
	return [self.monInfoDict getBaseAttack:self.monsterKey];
}

#warning TODO: figure out a better way to handle this
-(int32_t)defense{
	return [self.monInfoDict getBaseDefense:self.monsterKey];
}

-(int32_t)xp{
	return [self.monInfoDict getBaseXP:self.monsterKey];
}

-(int32_t)baseHp{
	return [self.monInfoDict getBaseHP:self.monsterKey];
}

-(float)treasureDropRate{
	return [self.monInfoDict getTreasureDropRate:self.monsterKey];
}

-(int32_t)encounterWeight{
	return [self.monInfoDict getEncounterWeight:self.monsterKey];
}


-(id)copyWithZone:(NSZone *)zone{
	(void)zone;
	return [self dtoCopy];
}

-(NSMutableDictionary *)mapable{
	return [NSDictionary objectToDictionary:self
		withTransformer:shDefaultTransformer
		withSet:nil];
}


-(void)setValue:(id)value forKey:(NSString *)key{
	//_monInfoDict was getting nil'ed out
	// when copying from the monster core data object
	if([key isEqualToString:@"_monInfoDict"] && nil == value) return;
	[super setValue:value forKey:key];
}

-(BOOL)shouldIgnoreProperty:(NSString *)propName{
	if([propName isEqualToString:@"monInfoDict"]) return YES;
	if([propName isEqualToString:@"mapable"]) return YES;
	return NO;
}

@end
