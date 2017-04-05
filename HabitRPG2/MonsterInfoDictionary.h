//
//  MonsterInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonsterInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
    +(instancetype)construct;
    -(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
    -(NSDictionary *)getMonsterInfo:(NSString *)monsterKey;
    -(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForZone:(NSString *)zoneKey;
    -(NSString *)getName:(NSString *)monsterKey;
    -(NSString *)getDescription:(NSString *)monsterKey;
@end
