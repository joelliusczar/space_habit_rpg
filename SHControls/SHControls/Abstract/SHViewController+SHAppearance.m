//
//  SHViewController+SHAppearance.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewController+SHAppearance.h"
#import "SHViewControllerAppearanceProxy.h"


static NSMutableDictionary<Class,SHVCAppearanceProxyContainer*> *_proxyContainerByClass = nil;


@interface SHViewController ()
@end

@implementation SHViewController (SHAppearance)

+(SHVCAppearanceProxyContainer *)proxyContainer {
	SHVCAppearanceProxyContainer *proxyContainer = _proxyContainerByClass[self.class];
	if(nil == proxyContainer) {
		SHViewController *reference = [[self.class alloc] init];
		proxyContainer = [[SHVCAppearanceProxyContainer alloc] initWithReference:reference];
		_proxyContainerByClass[(id<NSCopying>)self.class] = proxyContainer;
	}
	return proxyContainer;
}


+(instancetype)appearance {
	return self.proxyContainer.appearanceProxy;
}


+(instancetype)appearanceWhenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
	SHViewControllerAppearanceProxy *proxy = self.proxyContainer.appearanceClassHierarchyTracker[containerTypes];
	if(nil == proxy) {
		SHViewController *reference = self.proxyContainer.reference;
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		self.proxyContainer.appearanceClassHierarchyTracker[containerTypes] = proxy;
	}
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait {
	SHViewControllerAppearanceProxy *proxy = self.proxyContainer.proxyOnTraitTracker[trait];
	if(nil == proxy) {
		SHViewController *reference = self.proxyContainer.reference;
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		self.proxyContainer.proxyOnTraitTracker[trait] = proxy;
	}
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait
	whenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes
{
	SHTraitProxyDict *traitDict = self.proxyContainer.traitHierarchyTracker[containerTypes];
	if(nil == traitDict) {
		traitDict = [NSMutableDictionary dictionary];
		SHViewController *reference = self.proxyContainer.reference;
		SHViewControllerAppearanceProxy *proxy = [[SHViewControllerAppearanceProxy alloc]
			initWithReference:reference];
		traitDict[trait] = proxy;
		self.proxyContainer.traitHierarchyTracker[containerTypes] = traitDict;
		return proxy;
	}
	SHViewControllerAppearanceProxy *proxy = traitDict[trait];
	if(nil == proxy) {
		SHViewController *reference = self.proxyContainer.reference;
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		traitDict[trait] = proxy;
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
