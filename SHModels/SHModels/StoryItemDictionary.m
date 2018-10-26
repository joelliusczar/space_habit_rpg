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
    StoryItemDictionary *instance = [[StoryItemDictionary alloc] initWithPListKey:@"StoryItems"];
    instance.bundleClass = instance.class;
    return instance;
}

-(NSString*)getStoryItem:(NSString*)key{
  if(key&&self.treeDict[key]){
    return self.treeDict[key];
  }
  return @"";
}
@end
