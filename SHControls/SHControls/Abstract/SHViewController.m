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


typedef NSArray<Class<UIAppearanceContainer>> SHAppearanceHierarchy;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHViewControllerAppearanceProxy*> SHAppearanceClassHierarchyTracker;
typedef NSMutableDictionary<UITraitCollection*, SHViewControllerAppearanceProxy*> SHTraitProxyDict;
typedef NSMutableDictionary<UITraitCollection*, SHAppearanceClassHierarchyTracker*> SHTraitHierarchyDict;

static SHAppearanceClassHierarchyTracker *_appearanceHierarchyTracker = nil;
static SHTraitProxyDict *_proxyOnTraitTracker = nil;
static SHTraitHierarchyDict *_traitHierarchyTracker = nil;
static SHViewControllerAppearanceProxy *_singularAppearanceProxy = nil;

@interface SHViewController ()
@property (class, readonly, nonatomic) SHAppearanceClassHierarchyTracker *appearanceClassHierarchyTracker;
@property (class, readonly, nonatomic) SHTraitProxyDict *proxyOnTraitTracker;
@property (class, readonly, nonatomic) SHTraitHierarchyDict *traitHierarchyTracker;
@end

@implementation SHViewController 


+(SHAppearanceClassHierarchyTracker *)appearanceClassHierarchyTracker {
	if(nil == _appearanceHierarchyTracker) {
		_appearanceHierarchyTracker = [NSMutableDictionary dictionary];
	}
	return _appearanceHierarchyTracker;
}


+(SHTraitProxyDict *)proxyOnTraitTracker {
	if(nil == _proxyOnTraitTracker) {
		_proxyOnTraitTracker = [NSMutableDictionary dictionary];
	}
	return _proxyOnTraitTracker;
}


+(SHTraitHierarchyDict *)traitHierarchyTracker {
	if(nil == _traitHierarchyTracker) {
		_traitHierarchyTracker = [NSMutableDictionary dictionary];
	}
	return _traitHierarchyTracker;
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
	if(nil == _singularAppearanceProxy) {
		SHViewController *reference = [[self.class alloc] init];
		_singularAppearanceProxy = [[SHViewControllerAppearanceProxy alloc]
			initWithReference:reference];
	}
	return _singularAppearanceProxy;
}


+(instancetype)appearanceWhenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
	SHViewControllerAppearanceProxy *proxy = self.appearanceClassHierarchyTracker[containerTypes];
	if(nil == proxy) {
		SHViewController *reference = [[self.class alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		self.appearanceClassHierarchyTracker[containerTypes] = proxy;
	}
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait {
	SHViewControllerAppearanceProxy *proxy = self.proxyOnTraitTracker[trait];
	if(nil == proxy) {
		SHViewController *reference = [[self.class alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		self.proxyOnTraitTracker[trait] = proxy;
	}
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait
	whenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes
{
	SHAppearanceClassHierarchyTracker *hierarchyDict = self.traitHierarchyTracker[trait];
	if(nil == hierarchyDict) {
		hierarchyDict = [NSMutableDictionary dictionary];
		SHViewController *reference = [[self.class alloc] init];
		SHViewControllerAppearanceProxy *proxy = [[SHViewControllerAppearanceProxy alloc]
			initWithReference:reference];
		hierarchyDict[containerTypes] = proxy;
		self.traitHierarchyTracker[trait] = hierarchyDict;
		return proxy;
	}
	SHViewControllerAppearanceProxy *proxy = hierarchyDict[containerTypes];
	if(nil == proxy) {
		SHViewController *reference = [[self.class alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		hierarchyDict[containerTypes] = proxy;
	}
	return proxy;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

+ (nonnull instancetype)appearanceForTraitCollection:(nonnull UITraitCollection *)trait whenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ... {
	NSArray *containerTypes = [NSMutableArray variadicToArray:ContainerClass, nil];
	return [self appearanceForTraitCollection:trait whenContainedInInstancesOfClasses:containerTypes];
}


+ (nonnull instancetype)appearanceWhenContainedIn:(nullable Class<UIAppearanceContainer>)ContainerClass, ... {
	NSArray *containerTypes = [NSMutableArray variadicToArray:ContainerClass, nil];
	return [self appearanceWhenContainedInInstancesOfClasses:containerTypes];
}

#pragma GCC diagnostic pop


@end
