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
@property (strong, nonatomic) NSMutableArray<SHEnumerator*> *potentialMatches;
@end

@implementation SHAppearancePotentialMatches

-(NSMutableArray<SHEnumerator*> *)potentialMatches {
	if(nil == _potentialMatches) {
		_potentialMatches = [NSMutableArray array];
	}
	return _potentialMatches;
}


-(instancetype)initWithProxyContainer:(SHVCAppearanceProxyContainer*)proxyContainer
	withSHViewController:(SHViewController*)viewController
{
	if(self = [super init]) {
		_proxyContainer = proxyContainer;
		_viewController = viewController;
	}
	return self;
}


-(SHViewControllerAppearanceProxy*)getMatchIfAvailable {
	for(SHEnumerator<Class<UIAppearanceContainer>> *potentialMatch in self.potentialMatches) {
		if(nil == potentialMatch.current) {
			SHTraitProxyDict *traitProxyDict = self.proxyContainer
				.traitHierarchyTracker[potentialMatch.backend];
			if(traitProxyDict) {
				SHViewControllerAppearanceProxy *proxy = traitProxyDict[self.viewController.traitCollection];
				if(proxy) {
					return proxy;
				}
			}
			SHViewControllerAppearanceProxy *proxy =
				self.proxyContainer.appearanceClassHierarchyTracker[potentialMatch.backend];
			if(proxy) {
				return proxy;
			}
		}
		[potentialMatch moveNext];
	}
	return nil;
}


-(void)checkForInitialAppearanceMatches {
	NSAssert(self.viewController,@"no view controller");
	NSArray<SHAppearanceHierarchy*> *chains = self.proxyContainer
		.appearanceClassHierarchyTracker.allKeys;
	for(SHAppearanceHierarchy *chain in chains) {
		SHEnumerator<Class<UIAppearanceContainer>> *potentialMatch = [[SHEnumerator alloc]
			initWithBackend:chain];
		if([self.viewController isMemberOfClass:potentialMatch.current]) {
			[potentialMatch moveNext];
			[self.potentialMatches addObject:potentialMatch];
		}
	}
}


-(void)mergePotentialMatches:(SHAppearancePotentialMatches*)toBeMerged {
	[self.potentialMatches copyRangeFromArray:toBeMerged.potentialMatches];
}


@end
