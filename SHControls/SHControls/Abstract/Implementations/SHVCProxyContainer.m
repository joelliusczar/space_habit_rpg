//
//  SHVCProxyContainer.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHVCProxyContainer.h"

@interface SHVCProxyContainer ()

@end

@implementation SHVCProxyContainer


@synthesize appearanceProxies = _appearanceProxies;
-(SHAppearanceProxyTree*)appearanceProxies {
	if(nil == _appearanceProxies) {
		_appearanceProxies = [[SHInheritanceTree<Class, SHViewControllerAppearanceProxy *> alloc]
			initWithCompareFunction:^BOOL(Class a, Class b){
			return [a isSubclassOfClass: b];
		}
		withExactMatchFunction:^BOOL(Class a, Class b){
			return a == b;
		}];
	}
	return _appearanceProxies;
}


@synthesize appearanceClassHierarchyTracker = _appearanceClassHierarchyTracker;
-(SHHierarchyDict *)appearanceClassHierarchyTracker {
	if(nil == _appearanceClassHierarchyTracker) {
		_appearanceClassHierarchyTracker = [NSMutableDictionary dictionary];
	}
	return _appearanceClassHierarchyTracker;
}


@synthesize proxyOnTraitTracker = _proxyOnTraitTracker;
-(SHTraitProxyDict *)proxyOnTraitTracker {
	if(nil == _proxyOnTraitTracker) {
		_proxyOnTraitTracker = [NSMutableDictionary dictionary];
	}
	return _proxyOnTraitTracker;
}


@synthesize traitHierarchyTracker = _traitHierarchyTracker;
-(SHHierarchyTraitDict *)traitHierarchyTracker {
	if(nil == _traitHierarchyTracker) {
		_traitHierarchyTracker = [NSMutableDictionary dictionary];
	}
	return _traitHierarchyTracker;
}


@end
