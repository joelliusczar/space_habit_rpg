//
//	SHLinkViewController.m
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 8/3/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHLinkViewController.h"
@import SHCommon;

@implementation SHLinkViewController

-(UITapGestureRecognizer *)tapGestureRecognizer {
	if(nil == _tapGestureRecognizer) {
		_tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap_action:)];
	}
	return _tapGestureRecognizer;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	if(nil == self.navImageView.image) {
		SHIconBuilder *builder = [[SHIconBuilder alloc] init];
		builder.color = UIColor.grayColor;
		builder.backgroundColor = self.viewBackgroundColor;
		builder.size = CGSizeMake(50, 50);
		builder.thickness = 10;
		UIImage *arrow = [builder drawForwardArrow2];
		self.navImageView.image = arrow;
		[self.view addGestureRecognizer:self.tapGestureRecognizer];
	}
}


-(void)setupWithContext:(NSManagedObjectContext *)context
	andObjectID:(SHObjectIDWrapper*)objectIDWrapper
{
	self.context = context;
	self.objectIDWrapper = objectIDWrapper;
}

-(void)openNextScreen{
	@throw [NSException abstractException];
}


-(void)onTap_action:(UIGestureRecognizer *)recognizer {
	(void)recognizer;
	[self openNextScreen];
}


-(void)finishSetup {}

@end
