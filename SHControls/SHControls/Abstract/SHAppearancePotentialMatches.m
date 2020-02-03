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


-(instancetype)initWithProxyContainer:(SHVCAppearanceProxyContainer*)proxyContainer
	withTraitCollection:(UITraitCollection*)traitCollection
{
	if(self = [super init]) {
		_proxyContainer = proxyContainer;
		_traitCollection = traitCollection;
	}
	return self;
}


-(SHViewControllerAppearanceProxy*)scanPotentialMatchesForMatch:(NSArray<SHEnumerator*>*)potentialMatches {
	for(SHEnumerator<Class<UIAppearanceContainer>> *potentialMatch in potentialMatches) {
		if(nil == potentialMatch.current) {
			SHTraitProxyDict *traitProxyDict = self.proxyContainer
				.traitHierarchyTracker[potentialMatch.backend];
			if(traitProxyDict) {
				SHViewControllerAppearanceProxy *proxy = traitProxyDict[self.traitCollection];
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
	}
	return nil;
}

-(void)checkForInitialAppearanceMatches {
	self.potentialMatches = [NSMutableArray array];
	NSArray<SHAppearanceHierarchy*> *chains = self.proxyContainer
		.appearanceClassHierarchyTracker.allKeys;
	for(SHAppearanceHierarchy *chain in chains) {
		SHEnumerator<Class<UIAppearanceContainer>> *potentialMatch = [[SHEnumerator alloc]
			initWithBackend:chain];
		if([self isMemberOfClass:potentialMatch.current]) {
			[potentialMatch moveNext];
			[self.potentialMatches addObject:potentialMatch];
		}
	}
}


@end
