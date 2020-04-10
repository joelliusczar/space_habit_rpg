//
//  SHMonsterInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "SHInfoDictionary.h"
#import "SHMonsterDictionaryEntry.h"


@interface SHMonsterInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
@property (readonly,nonatomic,strong) SHInfoDictionary *infoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;
-(NSArray<NSString*> *)getMonsterKeyList:(NSString *)sectorKey;
-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey;
-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForSector:(NSString *)sectorKey;
-(SHMonsterDictionaryEntry *)getMonsterEntry:(NSString*)monsterKey;
@end
