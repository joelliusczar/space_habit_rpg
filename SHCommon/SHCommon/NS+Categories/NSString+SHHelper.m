//
//  NSString+SHHelper.m
//  SHCommon
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "NSString+SHHelper.h"

@implementation NSString (SHHelper)


-(char *)SH_unsafeStrCopy {
	const char *tmp = self.UTF8String;
	uint64_t len = strlen(tmp);
	char *copy = malloc(sizeof(char)*len);
	*copy = *tmp;
	return copy;
}

@end
