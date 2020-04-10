//
//	SHMonsterInfoDictionary.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 3/27/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMonsterInfoDictionary.h"
@import SHCommon;


@interface SHMonsterInfoDictionary()
@end

@implementation SHMonsterInfoDictionary

@synthesize infoDict = _infoDict;
-(SHInfoDictionary*)infoDict{
	if(nil == _infoDict){
		_infoDict = [[SHInfoDictionary alloc] initWithPListKey:@"MonsterInfo"
			withResourceUtil:self.resourceUtil];
	}
	return _infoDict;
}


-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
	if(self = [super init]){
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(NSArray<NSString *> *)getMonsterKeyList:(NSString *)sectorKey{
		return [self.infoDict getGroupKeyList:sectorKey];
}


-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForSector:(NSString *)sectorKey{
		return [self.infoDict getInfo:monsterKey forGroup:sectorKey];
}


-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey{
		return [self.infoDict getInfo:monsterKey];
}


-(SHMonsterDictionaryEntry *)getMonsterEntry:(NSString*)monsterKey{
	SHMonsterDictionaryEntry *entry = [[SHMonsterDictionaryEntry alloc] initWith:monsterKey
		withMonsterDict:[self.infoDict getInfo:monsterKey]];
	return entry;
}



@end
