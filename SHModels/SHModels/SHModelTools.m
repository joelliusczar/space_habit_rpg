//
//  ModelTools.m
//  SHModels
//
//  Created by Joel Pridgen on 3/5/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SHModelTools.h"
#import <SHCommon/SHCommonUtils.h>

uint shCalculateLvl(uint lvl,uint range){
	lvl = lvl?lvl:1;
	uint32_t minLvl = 0;
	if(lvl <= range){
		minLvl = 1;
		range += lvl;
	}
	else{
		minLvl = lvl - range;
		range = (2*range)+1;
	}
	
	return shRandomUInt(range) +minLvl;
}
