//
//	SHViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
#import "SHViewControllerAppearanceProxy.h"
@import SHCommon;
//SHAppearanceClassHierarchyTracker

typedef NSArray<Class<UIAppearanceContainer>> SHAppearanceHierarchy;
typedef NSMutableDictionary<SHAppearanceHierarchy*,SHViewControllerAppearanceProxy*> SHAppearanceClassHierarchyTracker;

static SHAppearanceClassHierarchyTracker *_appearanceHierarchyTracker = nil;

@interface SHViewController ()
@property (class, nonatomic) SHAppearanceClassHierarchyTracker *appearanceClassHierarchyTracker;
@end

@implementation SHViewController 


+(SHAppearanceClassHierarchyTracker *)appearanceClassHierarchyTracker {
	if(nil == _appearanceHierarchyTracker) {
		_appearanceHierarchyTracker = [NSMutableDictionary dictionary];
	}
	return _appearanceHierarchyTracker;
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


+(instancetype)appearance {
//	if(nil == _appearanceProxy) {
//		_appearanceProxy = [[SHViewControllerAppearanceProxy alloc] init];
//	}
//	return _appearanceProxy;
return nil;
}


+(instancetype)appearanceWhenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
	SHViewControllerAppearanceProxy *proxy = self.appearanceClassHierarchyTracker[containerTypes];
	
	return nil;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait { return nil; }


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait whenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
return nil;
}


@end
