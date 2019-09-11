//
//  SHStoryItemDictionary.h
//  SHModels
//
//  Created by Joel Pridgen on 10/24/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//
#import <SHCommon/SHResourceUtilityProtocol.h>
#import "SHInfoDictionary.h"

//not currently using this class
@interface SHStoryItemDictionary : NSObject
@property (readonly,nonatomic,strong) SHInfoDictionary* infoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;
-(NSString*)getStoryItem:(NSString*)key;
@end
