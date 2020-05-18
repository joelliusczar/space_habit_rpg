//
//  NSCalendar+SHHelper.m
//  SHCommon
//
//  Created by Joel Pridgen on 5/17/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "NSCalendar+SHHelper.h"

static NSCalendar *_appCalendar = nil;

@implementation NSCalendar (SHHelper)


+(NSCalendar*)SH_appCalendar {
	if(nil == _appCalendar) {
		_appCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	}
	return _appCalendar;
}


+(void)setSH_appCalendar:(NSCalendar *)SH_appCalendar {
	_appCalendar = SH_appCalendar;
}

@end
