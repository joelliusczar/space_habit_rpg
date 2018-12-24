//
//  StoryItemDictionary.m
//  SHModels
//
//  Created by Joel Pridgen on 10/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "StoryItemDictionary.h"

@implementation StoryItemDictionary


+(instancetype)new{
  StoryItemDictionary *instance = [[StoryItemDictionary alloc] init];
  return instance;
}

-(instancetype)init{
  if(self = [super init]){
    _storyInfoDict = [[InfoDictionary alloc] initWithPListKey:@"StoryItems"
      AndBundleClass:StoryItemDictionary.class];
  }
  return self;
}

-(NSString*)getStoryItem:(NSString*)key{
  if(key&&self.storyInfoDict.treeDict[key]){
    return self.storyInfoDict.treeDict[key];
  }
  return @"";
}
@end
