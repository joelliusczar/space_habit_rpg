//
//  SHAppearanceProxyTypedefs.h
//  SHControls
//
//  Created by Joel Pridgen on 3/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHAppearanceProxyTypedefs_h
#define SHAppearanceProxyTypedefs_h

@import SHCommon;

@class SHViewControllerAppearanceProxy;


typedef NSArray<Class<UIAppearanceContainer>> SHAppearanceHierarchy;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHViewControllerAppearanceProxy*> SHHierarchyDict;
typedef NSMutableDictionary<UITraitCollection*, SHViewControllerAppearanceProxy*> SHTraitProxyDict;
typedef NSMutableDictionary<UITraitCollection*, SHHierarchyDict*> SHHierarchyTraitDict;
typedef SHInheritanceTree<Class, SHViewControllerAppearanceProxy*> SHAppearanceProxyTree;

#import "SHViewControllerAppearanceProxy.h"
#endif /* SHAppearanceProxyTypedefs_h */
