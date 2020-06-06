//
//  NSString+SHHelper.m
//  SHCommon
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "NSString+SHHelper.h"
#import <string.h>
@import SHUtils_C;

@implementation NSString (SHHelper)


-(char *)SH_unsafeStrCopy {
	const char *tmp = self.UTF8String;
	uint64_t len = strlen(tmp);
	char *copy = malloc(sizeof(char) * (len + SH_NULL_CHAR_OFFSET));
	strcpy(copy, tmp);
	return copy;
}

@end
