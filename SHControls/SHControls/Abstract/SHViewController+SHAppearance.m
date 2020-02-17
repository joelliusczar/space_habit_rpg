//
//  SHViewController+SHAppearance.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewController+SHAppearance.h"
#import "SHViewControllerAppearanceProxy.h"


static SHVCProxyContainer *_proxyContainerByClass = nil;


@interface SHViewController ()
@end

@implementation SHViewController (SHAppearance)

-(UIColor*)viewBackgroundColor {
	return self.view.backgroundColor;
}


-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
	self.view.backgroundColor = viewBackgroundColor;
}


+(SHVCProxyContainer *)proxyContainer {
	if(nil == _proxyContainerByClass) {
		SHViewController *reference = [[self.class alloc] init];
		_proxyContainerByClass = [[SHVCProxyContainer alloc] initWithReference:reference];
	}
	return _proxyContainerByClass;
}


+(instancetype)appearance {
	SHViewControllerAppearanceProxy *proxy =
		[self.proxyContainer.appearanceProxies findExactMatch:self.class];
	if(nil == proxy) {
		SHViewController *reference = self.proxyContainer.reference;
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		[self.proxyContainer.appearanceProxies addObject:proxy withKey:self.class];
	}
	return proxy;
}


+(instancetype)appearanceWhenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
	NSArray<Class<UIAppearanceContainer>> *classChain = [@[self.class] arrayByAddingObjectsFromArray:containerTypes];
	SHViewControllerAppearanceProxy *proxy = self.proxyContainer.appearanceClassHierarchyTracker[classChain];
	if(nil == proxy) {
		SHViewController *reference = self.proxyContainer.reference;
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		self.proxyContainer.appearanceClassHierarchyTracker[classChain] = proxy;
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
	NSArray<Class<UIAppearanceContainer>> *classChain = [@[self.class] arrayByAddingObjectsFromArray:containerTypes];
	SHTraitProxyDict *traitDict = self.proxyContainer.traitHierarchyTracker[classChain];
	if(nil == traitDict) {
		traitDict = [NSMutableDictionary dictionary];
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
