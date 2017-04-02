//
//  ZoneInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,zoneGroupKeys) {
    LVL_1_ZONES = 1,
    LVL_5_ZONES = 5,
    LVL_10_ZONES = 10,
    LVL_15_ZONES = 15,
    LVL_20_ZONES = 20,
    LVL_25_ZONES = 25,
    LVL_30_ZONES = 30
};

@interface ZoneInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
+(instancetype)construct;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
-(NSDictionary *)getZoneInfo:(NSString *)zoneKey;
-(NSString *)getZoneName:(NSString *)zoneKey;
-(NSString *)getZoneDescription:(NSString *)zoneKey;
@end
