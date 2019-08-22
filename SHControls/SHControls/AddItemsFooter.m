//
//  SHAddItemsFooter.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHAddItemsFooter.h"
#import "SHEventInfo.h"

@implementation SHAddItemsFooter

-(IBAction)addItemBtn_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	shWrapReturnVoid wrappedCall = ^void(){
		SHEventInfo *e = eventInfoCopy;
		[self.delegate addItemBtn_press_action:e];
	};
	[self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
