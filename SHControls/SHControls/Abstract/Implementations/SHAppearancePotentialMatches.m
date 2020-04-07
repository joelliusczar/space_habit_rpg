//
//  SHAppearancePotentialMatch.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHAppearancePotentialMatches.h"
@import SHCommon;

@interface SHAppearancePotentialMatches ()
@end

@implementation SHAppearancePotentialMatches


-(instancetype)initWithProxyContainer:(SHVCProxyContainer*)proxyContainer
	withSHViewController:(SHViewController*)viewController
{
	if(self = [super init]) {
		_proxyContainer = proxyContainer;
		_viewControllerOrChild = viewController;
	}
	return self;
}

/*
	find if current class is an instance of first link in any inheritance chains
	for appearance,
*/
-(SHViewControllerAppearanceProxy * _Nullable)scanForMatchInOwnershipLineOrTraitAssociation {

	NSArray<SHAppearanceHierarchy*> *chains = self.proxyContainer
		.appearanceClassHierarchyTracker.allKeys;
	for(SHAppearanceHierarchy *chain in chains) {
		SHViewController *currentVC = self.viewControllerOrChild;
		NSEnumerator<Class<UIAppearanceContainer>> *classIter = chain.objectEnumerator;
		Class currentClass = [classIter nextObject];
		while(currentClass && currentVC) {
			if([currentVC isKindOfClass:currentClass]) {
				currentClass = [classIter nextObject];
			}
			currentVC = currentVC.prevViewController;
		}
		if(nil == currentClass) {
			SHTraitProxyDict *traitDict = self.proxyContainer.traitHierarchyTracker[chain];
			if(traitDict) {
				SHViewControllerAppearanceProxy *proxy = traitDict[self.viewControllerOrChild.traitCollection];
				if(proxy) {
					return proxy;
				}
			}
			SHViewControllerAppearanceProxy *proxy = self.proxyContainer
				.appearanceClassHierarchyTracker[chain];
			if(proxy) {
				return proxy;
			}
		}
	}
	return nil;
}


-(SHViewControllerAppearanceProxy*)getMatchIfAvailable {
	SHViewControllerAppearanceProxy *proxy = [self scanForMatchInOwnershipLineOrTraitAssociation];
	if(proxy) {
		return proxy;
	}
	//no appearance proxy was found from containIn or withTrait
	//so next we check if a proxy was associated with the simple appearance
	//or that of a parent class
	proxy = [self.proxyContainer.appearanceProxyTree findMatch:self.viewControllerOrChild.class];
	
	return proxy;
}



@end
