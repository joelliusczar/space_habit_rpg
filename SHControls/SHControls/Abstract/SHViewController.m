//
//	SHViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
#import "SHProxyTypeJunction.h"
@import SHCommon;




@interface SHViewController ()
@end

@implementation SHViewController


-(void)commonLoadView {
	NSBundle *bundle = [NSBundle bundleForClass:self.class];
	UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:bundle];
	NSArray *results = [nib instantiateWithOwner:self options:nil];
	if(results.count > 0) {
		self.view = results[0];
	}
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	SHProxyTypeJunction *junction = [SHViewController.tree findMatch: self.class];
	if(nil == junction) return;
	
	SHViewControllerAppearanceProxy* proxy = [junction getMostSpecificProxy:self with:self.traitCollection];
	if(proxy) {
		[proxy applyPropertyChangesToTarget:self];
	}
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.view.backgroundColor = color;
}


-(void)pushChildVC:(SHViewController*)child toViewOfParent:(UIView*)view{
	[view addSubview:child.view];
	[self addChildViewController:child];
	[child didMoveToParentViewController:self];
	child.view.translatesAutoresizingMaskIntoConstraints = NO;
	[child.view.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
	[child.view.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
	[child.view.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
	[child.view.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
	child.prevViewController = self;
}


-(void)arrangeAndPushChildVCToFront:(SHViewController *)child{
	[self pushChildVC:child toViewOfParent:self.view];
}


static void _popAnyViewControllerFromFront(UIViewController *vc) {
	[vc willMoveToParentViewController:nil];
	[vc.view removeFromSuperview];
	[vc removeFromParentViewController];
}


-(void)popVCFromFront{
	_popAnyViewControllerFromFront(self);
	self.prevViewController = nil;
}


-(void)popAllChildVCs {
	for (UIViewController *vc in self.childViewControllers) {
		if([vc isKindOfClass:SHViewController.class]) {
			[((SHViewController*)vc) popVCFromFront];
		}
		else {
			_popAnyViewControllerFromFront(vc);
		}
	}
}


@end
