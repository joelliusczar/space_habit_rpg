//
//  SHVCAppearanceProxyContainer.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHViewControllerAppearanceProxy.h"

@class SHViewControllerAppearanceProxy;

typedef NSArray<Class<UIAppearanceContainer>> SHAppearanceHierarchy;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHViewControllerAppearanceProxy*> SHHierarchyDict;
typedef NSMutableDictionary<UITraitCollection*, SHViewControllerAppearanceProxy*> SHTraitProxyDict;
typedef NSMutableDictionary<SHAppearanceHierarchy*, SHTraitProxyDict*> SHHierarchyTraitDict;

NS_ASSUME_NONNULL_BEGIN

@interface SHVCAppearanceProxyContainer : NSObject
@property (readonly, nonatomic) SHViewControllerAppearanceProxy *appearanceProxy;
@property (readonly, nonatomic) SHHierarchyDict *appearanceClassHierarchyTracker;
@property (readonly, nonatomic) SHTraitProxyDict *proxyOnTraitTracker;
@property (readonly, nonatomic) SHHierarchyTraitDict *traitHierarchyTracker;
@property (strong, nonatomic) SHViewController *reference;
-(instancetype)initWithReference:(SHViewController *)reference;
@end

NS_ASSUME_NONNULL_END
