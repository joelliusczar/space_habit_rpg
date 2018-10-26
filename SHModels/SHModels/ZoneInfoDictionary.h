//
//  ZoneInfoDictionary.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InfoDictionary.h"

@interface ZoneInfoDictionary : InfoDictionary
@property (nonatomic,assign) BOOL isTesting;
-(NSArray<NSString*> *)getGroupKeyList:(NSString *)key;
-(NSDictionary *)getZoneInfo:(NSString *)zoneKey;
-(NSString *)getZoneName:(NSString *)zoneKey;
-(NSString *)getZoneDescription:(NSString *)zoneKey;
@end
