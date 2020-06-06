//
//  SHViewController+SHAppearance.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewController+SHAppearance.h"
#import "SHViewControllerAppearanceProxy.h"


static SHProxyJunctionTree *_tree = nil;


@interface SHViewController ()
@end

@implementation SHViewController (SHAppearance)

-(UIColor*)viewBackgroundColor {
	return self.view.backgroundColor;
}


-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
	self.view.backgroundColor = viewBackgroundColor;
}


+(SHProxyJunctionTree *)tree {
	if(nil == _tree) {
		_tree = [[SHInheritanceTree<Class, SHProxyTypeJunction *> alloc]
			initWithCompareFunction:^BOOL(Class a, Class b){
			return [a isSubclassOfClass: b];
		}
		withExactMatchFunction:^BOOL(Class a, Class b){
			return a == b;
		}];
	}
	return _tree;
}


+(instancetype)appearance {
	//we want exact match because otherwise every property will
	//always go all the way up to the top
	SHProxyTypeJunction *junction = [self.tree findExactMatch: self];
	SHViewControllerAppearanceProxy *proxy = nil;
	if(nil == junction) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		junction = [[SHProxyTypeJunction alloc] initWithReference:reference];
		junction.singleProxy = proxy;
		[self.tree addObjectAndGetNearestParent: junction withKey:self];
		return proxy;
	}
	proxy = junction.singleProxy;
	if(nil == proxy) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		junction.singleProxy = proxy;
	}
	return proxy;
}


+(instancetype)appearanceWhenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes {
	SHProxyTypeJunction *junction = [self.tree findExactMatch: self];
	SHViewControllerAppearanceProxy *proxy = nil;
	if(nil == junction) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		junction = [[SHProxyTypeJunction alloc] initWithReference:reference];
		junction.classListDict[containerTypes] = proxy;
		[self.tree addObjectAndGetNearestParent: junction withKey: self];
		return proxy;
	}
	proxy = junction.classListDict[containerTypes];
	if(proxy) {
		return proxy;
	}
	SHViewController *reference = [[self alloc] init];
	proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
	junction.classListDict[containerTypes] = proxy;
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait {
	SHProxyTypeJunction *junction = [self.tree findExactMatch: self];
	SHViewControllerAppearanceProxy *proxy = nil;
	if(nil == junction) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		junction = [[SHProxyTypeJunction alloc] initWithReference:reference];
		junction.traitDict[trait] = proxy;
		[self.tree addObjectAndGetNearestParent: junction withKey: self];
		return proxy;
	}
	proxy = junction.traitDict[trait];
	if(proxy) {
			return proxy;
	}
	SHViewController *reference = [[self alloc] init];
	proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
	junction.traitDict[trait] = proxy;
	return proxy;
}


+(instancetype)appearanceForTraitCollection:(UITraitCollection *)trait
	whenContainedInInstancesOfClasses:(NSArray<Class<UIAppearanceContainer>> *)containerTypes
{
	SHProxyTypeJunction *junction = [self.tree findExactMatch: self];
	SHViewControllerAppearanceProxy *proxy = nil;
	if(nil == junction) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		junction = [[SHProxyTypeJunction alloc] initWithReference:reference];
		SHHierarchyDict *classListDict = [NSMutableDictionary dictionary];
		junction.classListTraitDict[trait] = classListDict;
		classListDict[containerTypes] = proxy;
		[self.tree addObjectAndGetNearestParent: junction withKey: self];
		return proxy;
	}
	SHHierarchyDict *classListDict = junction.classListTraitDict[trait];
	if(nil == classListDict) {
		classListDict = [NSMutableDictionary dictionary];
		junction.classListTraitDict[trait] = classListDict;
	}
	proxy = classListDict[containerTypes];
	if(nil == proxy) {
		SHViewController *reference = [[self alloc] init];
		proxy = [[SHViewControllerAppearanceProxy alloc] initWithReference:reference];
		classListDict[containerTypes] = proxy;
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
