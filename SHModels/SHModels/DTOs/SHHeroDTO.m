//
//	SHHeroDTO.m
//	SHModels
//
//	Created by Joel Pridgen on 4/6/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHHeroDTO.h"
#import <SHCommon/NSObject+Helper.h>


@implementation SHHeroDTO


-(id)copyWithZone:(NSZone *)zone{
	(void)zone;
	return [self narrowCopy];
}

@end
