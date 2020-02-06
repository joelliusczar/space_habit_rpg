//
//	SHViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
#import "SHViewControllerAppearanceProxy.h"
#import "SHAppearancePotentialMatches.h"
@import SHCommon;




@interface SHViewController ()
@property (strong, nonatomic) SHAppearancePotentialMatches *matches;
@end

@implementation SHViewController 


-(instancetype)initWithCoder:(NSCoder *)coder {
	if(self = [super initWithCoder:coder]){
	}
	return self;
}


-(instancetype)init {
	if(self = [super init]){
		//[self checkForInitialAppearanceMatches];
	}
	return self;
}


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		//[self checkForInitialAppearanceMatches];
	}
	return self;
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
