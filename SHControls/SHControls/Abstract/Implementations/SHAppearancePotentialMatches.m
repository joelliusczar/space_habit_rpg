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
		_viewController = viewController;
	}
	return self;
}


-(SHViewControllerAppearanceProxy * _Nullable)scanForMatch {
	NSArray<SHAppearanceHierarchy*> *chains = self.proxyContainer
	.appearanceClassHierarchyTracker.allKeys;
	for(SHAppearanceHierarchy *chain in chains) {
		SHViewController *currentVC = self.viewController;
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
				SHViewControllerAppearanceProxy *proxy = traitDict[self.viewController.traitCollection];
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
	SHViewControllerAppearanceProxy *proxy = [self scanForMatch];
	if(proxy) {
		return proxy;
	}
	proxy = [self.proxyContainer.appearanceProxies findMatch:self.viewController.class];
	
	return proxy;
}



@end
