//
//  ModelTools.m
//  SHModels
//
//  Created by Joel Pridgen on 3/5/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHModelTools.h"
@import SHCommon;

NSUInteger shCalculateLvl(NSUInteger lvl,NSUInteger range){
	lvl = lvl?lvl:1;
	NSUInteger minLvl = 0;
	if(lvl <= range){
		minLvl = 1;
		range += lvl;
	}
	else{
		minLvl = lvl - range;
		range = (2*range)+1;
	}
	
	return (NSUInteger)shRandomUInt((uint)range) +minLvl;
}
