//
//	SHConfigDTO.m
//	SHModels
//
//	Created by Joel Pridgen on 4/7/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHConfigDTO.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHConfigDTO


-(id)copyWithZone:(NSZone *)zone{
	(void)zone;
	return [self dtoCopy];
}


@end
