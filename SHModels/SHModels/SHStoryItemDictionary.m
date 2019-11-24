//
//	SHStoryItemDictionary.m
//	SHModels
//
//	Created by Joel Pridgen on 10/24/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHStoryItemDictionary.h"

@implementation SHStoryItemDictionary


@synthesize infoDict = _infoDict;
-(SHInfoDictionary*)infoDict{
	if(nil == _infoDict){
		_infoDict = [[SHInfoDictionary alloc] initWithPListKey:@"StoryItems"
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


-(NSString*)getStoryItem:(NSString*)key{
	if(key&&self.infoDict.treeDict[key]){
		return self.infoDict.treeDict[key];
	}
	return @"";
}
@end
