//
//	SHLinkViewController.m
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/3/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHLinkViewController.h"
#import <SHCommon/NSException+SHCommonExceptions.h>

@implementation SHLinkViewController


-(void)setupWithContext:(NSManagedObjectContext *)context
	andObjectID:(SHObjectIDWrapper*)objectIDWrapper
{
	self.context = context;
	self.objectIDWrapper = objectIDWrapper;
}

-(void)openNextScreen{
	@throw [NSException abstractException];
}

-(void)onBeginTap_action:(SHView *)sender withEvent:(UIEvent*)event{
	(void)sender; (void)event;
	[self openNextScreen];
}


@end
