//
//	SHApplication.m
//	SpaceHabitRPG
//
//	Created by Joel Pridgen on 6/26/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHApplication.h"

@implementation SHApplication

- (void)sendEvent:(UIEvent*)event {
	//handle the event (you will probably just reset a timer)
//	for(UITouch *t in event.allTouches){
//	NSLog(@"%@ %lu",
//		NSStringFromClass(t.view.class),
//		(uintptr_t)t.view);
//	}
	[super sendEvent:event];
}


@end
