//
//  ZoneInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZoneInfoDictionary : NSObject
@property (nonatomic,assign) BOOL isTesting;
+(instancetype)construct;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
-(NSDictionary *)getZoneInfo:(NSString *)zoneKey;
-(NSString *)getZoneName:(NSString *)zoneKey;
-(NSString *)getZoneDescription:(NSString *)zoneKey;
@end
