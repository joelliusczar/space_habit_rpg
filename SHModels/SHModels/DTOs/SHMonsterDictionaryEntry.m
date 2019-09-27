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


-(instancetype)initWith:(NSString*)monsterKey withMonsterDict:(NSDictionary*)monInfoDict{
	if(self = [super init]){
		_monsterKey = monsterKey;
		_monInfoDict = monInfoDict;
	}
	return self;
}


-(NSString *)fullName{
	NSString *monName = self.monInfoDict[@"NAME"];;
	#if SH_EXTRA_ERRORS
		NSAssert(monName,@"Monster name should not be null");
	#else
	if(nil == monName){
		return @"";
	}
	#endif
	return monName;
}


-(NSString *)headline{
	NSString *grammaticalAgreement = self.monInfoDict[@"GRAMMATICAL_AGREEMENT"];
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

-(NSString*)synopsis{
	NSString *desc = self.monInfoDict[@"DESCRIPTION"];
	#if SH_EXTRA_ERRORS
		NSAssert(desc,@"Monster description should not be null");
	#else
		if(nil == desc){
			return @"";
		}
	#endif
	return desc;
}

-(int32_t)baseAttack{
	NSNumber *atkLvl = (NSNumber *)self.monInfoDict[@"ATTACK_LVL"];
	#if SH_EXTRA_ERRORS
		NSAssert(atkLvl,@"Basic attack should not be null");
	#else
		if(nil == atkLvl){
			return 0;
		}
	#endif
	return atkLvl.intValue;
}

#warning TODO: figure out a better way to handle this
-(int32_t)defense{
	NSNumber *defLvl = (NSNumber *)self.monInfoDict[@"DEFENSE_LVL"];
	#if SH_EXTRA_ERRORS
		NSAssert(defLvl,@"Basic defense should not be null");
	#else
		if(nil == defLvl){
			return 0;
		}
	#endif
	return defLvl.intValue;
}

-(int32_t)baseXp{
	NSNumber *xp = (NSNumber *)self.monInfoDict[@"BASE_XP_REWARD"];
	#if SH_EXTRA_ERRORS
		NSAssert(xp,@"Basic XP should not be null");
	#else
		if(nil == xp){
			return 0;
		}
	#endif
	return xp.intValue;
}

-(int32_t)baseHp{
	NSNumber *hp = (NSNumber *)self.monInfoDict[@"HP"];
	#if SH_EXTRA_ERRORS
		NSAssert(hp,@"Basic defense should not be null");
	#else
		if(nil == hp){
			return 0;
		}
	#endif
	return hp.intValue;
}

-(float)treasureDropRate{
	NSNumber *dropRate = (NSNumber *)self.monInfoDict[@"TREASURE_DROP_RATE"];
	#if SH_EXTRA_ERRORS
		NSAssert(dropRate,@"Treasure drop rate should not be null");
	#else
		if(nil == dropRate){
			return 0;
		}
	#endif
	return dropRate.floatValue;
}

-(int32_t)encounterWeight{
	NSNumber *encounterWeight = (NSNumber *)self.monInfoDict[@"ENCOUNTER_WEIGHT"];
	#if SH_EXTRA_ERRORS
		NSAssert(encounterWeight,@"Encounter rate should not be null");
	#else
		if(nil == encounterWeight){
			return 0;
		}
	#endif
	return encounterWeight.intValue;
}


-(id)copyWithZone:(NSZone *)zone{
	(void)zone;
	return [self narrowCopy];
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
