//
//  ZoneHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoneHelper : NSObject
+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl;
+(NSString*)generateFullZoneNameSuffix:(NSUInteger)visitCount;
+(NSArray*)getSymbols;
+(NSString*)getSymbolSuffix:(NSUInteger)visitCount;
+(NSArray*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl;
@end
