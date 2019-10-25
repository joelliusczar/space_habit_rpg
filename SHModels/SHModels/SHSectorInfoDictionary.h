//
//  SHSectorInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHInfoDictionary.h"
@import Foundation;
@import SHCommon;

@interface SHSectorInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
@property (readonly,nonatomic,strong) SHInfoDictionary *infoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
-(NSDictionary *)getSectorInfo:(NSString *)sectorKey;
-(NSString *)getSectorName:(NSString *)sectorKey;
-(NSString *)getSectorDescription:(NSString *)sectorKey;
@end
