//
//  StoryItemDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//
#import <SHCommon/P_ResourceUtility.h>
#import "InfoDictionary.h"

//not currently using this class
@interface StoryItemDictionary : NSObject
@property (readonly,nonatomic,strong) InfoDictionary* infoDict;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtil;
+(instancetype)newWithResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil;
-(NSString*)getStoryItem:(NSString*)key;
@end
