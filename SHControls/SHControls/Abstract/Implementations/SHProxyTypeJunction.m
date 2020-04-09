//
//  SHProxyTypeJunction.m
//  SHControls
//
//  Created by Joel Pridgen on 4/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHProxyTypeJunction.h"

@interface SHProxyTypeJunction ()
@end

@implementation SHProxyTypeJunction

-(SHHierarchyDict*)classListDict {
	if(nil == _classListDict) {
		_classListDict = [NSMutableDictionary dictionary];
	}
	return _classListDict;
}


-(SHTraitProxyDict *)traitDict {
	if(nil == _traitDict) {
		_traitDict = [NSMutableDictionary dictionary];
	}
	return _traitDict;
}


-(SHHierarchyTraitDict*)classListTraitDict {
	if(nil == _classListTraitDict) {
		_classListTraitDict = [NSMutableDictionary dictionary];
	}
	return _classListTraitDict;
}

-(instancetype)initWithReference:(SHViewController *)reference {
	if(self = [super init]) {
		_singleProxy = [[SHViewControllerAppearanceProxy alloc] initWithReference: reference];
	}
	return self;
}


static SHViewControllerAppearanceProxy* _scanClassLists(SHHierarchyDict *classListDict,
	SHViewController *viewController)
{
	NSArray<SHAppearanceHierarchy*> *chains = classListDict.allKeys;
	for(SHAppearanceHierarchy *chain in chains) {
		SHViewController *currentVC = viewController;
		NSEnumerator<Class<UIAppearanceContainer>> *classIter = chain.objectEnumerator;
		Class currentClass = [classIter nextObject];
		while(currentClass && currentVC) {
			if([currentVC isKindOfClass:currentClass]) {
				currentClass = [classIter nextObject];
			}
			currentVC = currentVC.prevViewController;
		}
		if(nil == currentClass) {
			SHViewControllerAppearanceProxy *proxy = classListDict[chain];
			if(proxy) {
				return proxy;
			}
		}
	}
	return nil;
}


-(SHViewControllerAppearanceProxy *)getMostSpecificProxy:(SHViewController *)viewController
	with:(UITraitCollection*)traits
{
	SHHierarchyDict *classListDict = self.classListTraitDict[traits];
	if(classListDict) {
		SHViewControllerAppearanceProxy *proxy = _scanClassLists(classListDict, viewController);
		if(proxy) {
			return proxy;
		}
	}
	
	SHViewControllerAppearanceProxy *proxy = _scanClassLists(self.classListDict, viewController);
	if(proxy) {
		return proxy;
	}
	
	proxy = self.traitDict[traits];
	if(proxy) {
		return proxy;
	}
	
	return self.singleProxy;
}


-(SHViewControllerAppearanceProxy *)getMostSpecificProxy:(SHViewController *)viewController {
	
	SHViewControllerAppearanceProxy *proxy = _scanClassLists(self.classListDict, viewController);
	if(proxy) {
		return proxy;
	}
	
	return self.singleProxy;
}


@end
