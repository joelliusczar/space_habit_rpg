//
//  SHMonsterInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHInfoDictionary.h"
#import "SHMonsterDictionaryEntry.h"

@class SHMonsterDictionaryEntry;

@interface SHMonsterInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
@property (readonly,nonatomic,strong) SHInfoDictionary *infoDict;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;
-(NSArray<NSString*> *)getMonsterKeyList:(NSString *)sectorKey;
-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey;
-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForSector:(NSString *)sectorKey;
-(SHMonsterDictionaryEntry *)getMonsterEntry:(NSString*)monsterKey;
-(NSString *)getName:(NSString *)monsterKey;
-(NSString *)getDescription:(NSString *)monsterKey;
-(int32_t)getBaseAttack:(NSString *)monsterKey;
-(int32_t)getBaseDefense:(NSString *)monsterKey;
-(int32_t)getBaseXP:(NSString *)monsterKey;
-(int32_t)getBaseHP:(NSString *)monsterKey;
-(float)getTreasureDropRate:(NSString *)monsterKey;
-(int32_t)getEncounterWeight:(NSString *)monsterKey;
-(NSString *)getGrammaticalAgreement:(NSString *)monsterKey;
@end
