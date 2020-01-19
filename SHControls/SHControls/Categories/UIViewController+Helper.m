//
//	UIViewController+Helper.m
//	SHControls
//
//	Created by Joel Pridgen on 12/23/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "UIView+Helpers.h"

@implementation UIViewController (Helper)


+(instancetype)newWithDefaultNib {
	Class cls = self;
	NSBundle *bundle = [NSBundle bundleForClass:cls];
	
	UIViewController *instance = [[cls alloc] initWithNibName:NSStringFromClass(cls) bundle:bundle];
	return instance;
}


-(void)pushChildVC:(UIViewController*)child toViewOfParent:(UIView*)view{
	[view addSubview:child.view];
	[self addChildViewController:child];
	[child didMoveToParentViewController:self];
	child.view.translatesAutoresizingMaskIntoConstraints = NO;
	[child.view.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
	[child.view.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
	[child.view.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
	[child.view.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
}


-(void)arrangeAndPushChildVCToFront:(UIViewController *)child{
	[self pushChildVC:child toViewOfParent:self.view];
}


-(void)popVCFromFront{
	[self willMoveToParentViewController:nil];
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
}


-(void)popAllChildVCs{
	for (UIViewController *child in self.childViewControllers) {
		[child popVCFromFront];
	}
}


-(void)showErrorView:(NSString*)name withError:(NSError*)error{
	(void)name;
	(void)error;
}


@end
