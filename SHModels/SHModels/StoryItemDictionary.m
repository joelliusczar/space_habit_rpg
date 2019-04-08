//
//  StoryItemDictionary.m
//  SHModels
//
//  Created by Joel Pridgen on 10/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "StoryItemDictionary.h"

@implementation StoryItemDictionary


@synthesize infoDict = _infoDict;
-(InfoDictionary*)infoDict{
  if(nil == _infoDict){
    _infoDict = [[InfoDictionary alloc] initWithPListKey:@"StoryItems"
      AndBundleClass:StoryItemDictionary.class AndResourceUtil:self.resourceUtil];
  }
  return _infoDict;
}


+(instancetype)newWithResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil{
  StoryItemDictionary *instance = [StoryItemDictionary new];
  instance.resourceUtil = resourceUtil;
  return instance;
}

-(NSString*)getStoryItem:(NSString*)key{
  if(key&&self.infoDict.treeDict[key]){
    return self.infoDict.treeDict[key];
  }
  return @"";
}
@end
