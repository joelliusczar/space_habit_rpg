//
//  SHVCProxyContainer.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHViewControllerAppearanceProxy.h"
@import SHCommon;

@class SHViewControllerAppearanceProxy;

typedef NSArray<Class<UIAppearanceContainer>> SHAppearanceHierarchy;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHViewControllerAppearanceProxy*> SHHierarchyDict;
typedef NSMutableDictionary<UITraitCollection*, SHViewControllerAppearanceProxy*> SHTraitProxyDict;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHTraitProxyDict*> SHHierarchyTraitDict;
typedef SHInheritanceTree<Class, SHViewControllerAppearanceProxy*> SHAppearanceProxyTree;

NS_ASSUME_NONNULL_BEGIN

@interface SHVCProxyContainer : NSObject
@property (readonly, nonatomic) SHAppearanceProxyTree *appearanceProxies;
@property (readonly, nonatomic) SHHierarchyDict *appearanceClassHierarchyTracker;
@property (readonly, nonatomic) SHTraitProxyDict *proxyOnTraitTracker;
@property (readonly, nonatomic) SHHierarchyTraitDict *traitHierarchyTracker;

@end

NS_ASSUME_NONNULL_END
