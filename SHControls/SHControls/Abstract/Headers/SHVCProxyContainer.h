//
//  SHVCProxyContainer.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHAppearanceProxyTypedefs.h"
@import Foundation;
@import SHCommon;


NS_ASSUME_NONNULL_BEGIN

@interface SHVCProxyContainer : NSObject
@property (readonly, nonatomic) SHAppearanceProxyTree *appearanceProxyTree;
@property (readonly, nonatomic) SHHierarchyDict *appearanceClassHierarchyTracker;
@property (readonly, nonatomic) SHTraitProxyDict *proxyOnTraitTracker;
@property (readonly, nonatomic) SHHierarchyTraitDict *traitHierarchyTracker;
@end

NS_ASSUME_NONNULL_END
