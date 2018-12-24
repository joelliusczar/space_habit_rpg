//
//  StoryItemDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "InfoDictionary.h"
//not currently using this class
@interface StoryItemDictionary : NSObject
@property (readonly,nonatomic,strong) InfoDictionary* storyInfoDict;
-(NSString*)getStoryItem:(NSString*)key;
@end
