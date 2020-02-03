//
//  SHVCAppearanceProxyContainer.m
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHVCAppearanceProxyContainer.h"

@interface SHVCAppearanceProxyContainer ()

@end

@implementation SHVCAppearanceProxyContainer


@synthesize appearanceProxy = _appearanceProxy;
-(SHViewControllerAppearanceProxy*)appearanceProxy {
	NSAssert(self.reference, @"No SHViewController was supplied as a reference");
	if(nil == _appearanceProxy) {
		_appearanceProxy = [[SHViewControllerAppearanceProxy alloc]
			initWithReference:self.reference];
	}
	return _appearanceProxy;
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


-(instancetype)initWithReference:(SHViewController *)reference {
	if(self = [super init]) {
		_reference = reference;
	}
	return self;
}

@end
