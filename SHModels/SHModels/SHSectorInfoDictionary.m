//
//	SHSectorInfoDictionary.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 1/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorInfoDictionary.h"
@import SHCommon;


@interface SHSectorInfoDictionary()
@end

@implementation SHSectorInfoDictionary

@synthesize infoDict = _infoDict;
-(SHInfoDictionary*)infoDict{
	if(nil == _infoDict){
		_infoDict = [[SHInfoDictionary alloc] initWithPListKey:@"SectorInfo"
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


-(NSArray<NSString*>*)getGroupKeyList:(NSString *)key{
	return [self.infoDict getGroupKeyList:key];
}


-(NSDictionary *)getSectorInfo:(NSString *)sectorKey{
	return [self.infoDict getInfo:sectorKey];
}

-(NSString *)getSectorName:(NSString *)sectorKey{
	return [self getSectorInfo:sectorKey][@"Name"];
}

-(NSString *)getSectorDescription:(NSString *)sectorKey{
	return [self getSectorInfo:sectorKey][@"Description"];
}

@end
