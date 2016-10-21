//
//  ZoneHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "ZoneHelper.h"
#import "ZoneDescriptions.h"
#include "stdlib.h"

@implementation ZoneHelper

+(NSArray *)getZoneGroup:(NSInteger)key{
    if(key == LVL_5_ZONES){
        return @[ASTEROID_FIELD_KEY,SOLAR_KEY,UNCHARTED_KEY,BACKWATER_KEY];
    }
    else if(key == LVL_10_ZONES){
        return @[GARBAGE_BALL_KEY,CAVE_KEY,DEFENSE_KEY,RESORT_KEY];
    }
    else if(key == LVL_15_ZONES){
        return @[METROPOLIS_KEY,TEMPLE_KEY,INFESTATION_KEY,GREY_KEY];
    }
    else if(key == LVL_20_ZONES){
        return @[MALESTERIUM_KEY,SKY_KEY,PSYCHEDELIC_KEY,OCEAN_KEY];
    }
    else if(key == LVL_25_ZONES){
        return @[WEB_KEY,NO_MOON_KEY,WARP_KEY,EVENT_HORIZON_KEY];
    }
    else if(key == LVL_30_ZONES){
        return @[WORLD_END_KEY,HELL_KEY,BEGINNING_KEY,INFINITE_KEY];
    }
    else{
        return @[GAS_KEY,EMPTY_SPACE_KEY,NEBULA_KEY,SAFE_SPACE_KEY];
    }
}

+(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl{
    NSArray *groupKeys = [ZoneHelper getUnlockedZoneGroupKeys: heroLvl];
    int r = arc4random_uniform(groupKeys.count);
    NSInteger groupKey = [((NSNumber*)[groupKeys objectAtIndex:r]) integerValue];
    NSArray *zoneList = [ZoneHelper getZoneGroup:groupKey];
    r = arc4random_uniform(zoneList.count);
    return [zoneList objectAtIndex:r];
}



+(NSString*)generateFullZoneNameSuffix:(NSUInteger)visitCount{
    if(visitCount < 1){
        return @"";
    }
    
    NSArray *symbols = [ZoneHelper getSymbols];
    NSUInteger numericSuffix = 0;
    if(visitCount > ((symbols.count -1)*symbols.count)){
        numericSuffix = [ZoneHelper getNumericSuffixForZoneVisit:visitCount LengthOfSymbolsTable:symbols.count];
        visitCount = [ZoneHelper adjustVisitCountForHugeNumbers:visitCount LengthOfSymbolsTable:symbols.count];
    }
    NSUInteger adjustedVisitCount = [ZoneHelper skipPowersOfBaseInNumber:visitCount Base:symbols.count];
    NSMutableString *suffix = [NSMutableString stringWithString:[ZoneHelper getSymbolSuffix:adjustedVisitCount]];
    if(numericSuffix > 0){
        [suffix appendString:[NSString stringWithFormat:@"%d",numericSuffix]];
    }
    return [suffix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}


+(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
    NSMutableString *suffix = [NSMutableString string];
    NSArray *symbols = [ZoneHelper getSymbols];
    while(visitCount > 0){
        NSUInteger symbolIndex = visitCount % symbols.count;
        visitCount /= symbols.count;
        [suffix appendFormat:@"%@ ",[symbols objectAtIndex:symbolIndex]];
    }
    return [NSString stringWithString:suffix];
}

+(NSUInteger)adjustVisitCountForHugeNumbers:(NSUInteger)visitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    return visitCount % ((symbolsLen -1 )*symbolsLen);
}

+(NSArray *)getSymbols{
    NSArray *symbols = @[@"",@"Alpha", @"Beta",@"Cain",@"Delta", //4
                                 @"Epsilon",@"Foxtrot",@"September",@"October", //8
                                 @"November",@"Kilo",@"Juliett",@"Romeo",@"Silver",@"Deckard", //14
                                 @"Sierra",@"Tango",@"Zeta",@"Theta",@"July",@"Ludwig",@"Tyrell", //21
                                 @"Lambda",@"Mu",@"London",@"Victor",@"Quintin",@"Gold", //27
                                 @"Whiskey",@"Xray",@"Zulu",@"Pi",@"Rho",@"Antilles",@"Blanca", //34
                                 @"Sigma",@"Tau",@"India",@"Hector",@"Quebec",@"Waltz",@"Sapphire", //41
                                 @"Tokyo",@"Ramesses",@"Washington",@"Darius",@"Emerald",@"Midgard", //47
                                 @"Futura",@"Charlotte",@"Flanders",@"Berlin",@"Onion",@"Ruby", //53
                                 @"David",@"Pizza",@"Lazlo",@"Kong",@"Jerico",@"Diamond", //59
                                 @"Black",@"White",@"Olaf",@"Biggs",@"Wedge",@"Tyrannus", //65
                                 @"Richter",@"Medusa",@"Swan",@"Gemini",@"Noir",@"Xerxes",//71
                                 @"TNT",@"Plutonia",@"Cerberus",@"Tiberius", //75
                                 @"Arcturus",@"Prime",@"Tarsonis",@"Babylon",@"Sparta",//80
                                 @"Atlanta",@"Yutani",@"Python",@"Ridley",@"Midway", //85
                                 @"Bismark",@"Dextera",@"Dominus",@"Jejunum", //89
                                 @"Superior",@"Distal",@"Eurebus",@"Indigo", //93
                                 @"Xs",@"Rex",@"Titan",@"Zen",@"Apex",@"Omega",@"Zed"];
    return symbols;
}

+(NSUInteger)skipPowersOfBaseInNumber:(NSUInteger)num Base:(NSUInteger)base{
    /*
     Numbers naturally want to follow this pattern:
     0,A,B,C,...,Y,Z,A0,AA,AB,AC,...,AY,AZ,B0,BA,BB,BC
     But I want zone suffix naming system to follow this pattern:
     0,A,B,C,...,Y,Z,AA,AB,AC,...,AY,AZ,BA,BB,BC,...
     This function adjust numbers to fit the wanted pattern,
     i.e. without the proverbial mulitples of 10
     The accuracy of this function becomes unreliable after base^2

     */
    NSUInteger adjusterNum = num + (num/base);
    return num + (adjusterNum / base);
}

+(NSUInteger)getNumericSuffixForZoneVisit:(NSUInteger)zoneVisitCount LengthOfSymbolsTable:(NSUInteger)symbolsLen{
    //#the -1 on the first array length is to account for the single symbol range of items
    return zoneVisitCount / ((symbolsLen-1) * symbolsLen) + 1; //#+1 because the 1 suffix would be redundant
}

+(NSArray*)getUnlockedZoneGroupKeys:(NSUInteger)heroLvl{
    NSMutableArray *availableZoneGroups  = [[NSMutableArray alloc]init];
    [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_1_ZONES] ];
    if(heroLvl >= 5){
        [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_5_ZONES] ];
        if(heroLvl >= 10){
            [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_10_ZONES] ];
            if(heroLvl >= 15){
                [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_15_ZONES] ];
                if(heroLvl >= 20){
                    [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_20_ZONES] ];
                    if(heroLvl >= 25){
                        [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_25_ZONES] ];
                        if(heroLvl >= 30){
                            [availableZoneGroups addObject:[NSNumber numberWithInteger:LVL_30_ZONES] ];
                        }
                    }
                }
            }
        }
    }
    return [NSArray arrayWithArray:availableZoneGroups];
    
}

@end
