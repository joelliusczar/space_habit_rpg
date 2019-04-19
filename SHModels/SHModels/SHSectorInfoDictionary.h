//
//  SHSectorInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHResourceUtilityProtocol.h>
#import "SHInfoDictionary.h"

@interface SHSectorInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
@property (readonly,nonatomic,strong) SHInfoDictionary *infoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
+(instancetype)newWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
-(NSDictionary *)getSectorInfo:(NSString *)sectorKey;
-(NSString *)getSectorName:(NSString *)sectorKey;
-(NSString *)getSectorDescription:(NSString *)sectorKey;
@end
