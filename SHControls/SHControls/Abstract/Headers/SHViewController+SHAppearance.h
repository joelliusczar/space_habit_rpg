//
//  SHViewController+SHAppearance.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHViewController.h"
#import "SHProxyTypeJunction.h"
@import UIKit;
@import SHCommon;

@class SHProxyTypeJunction;
typedef SHInheritanceTree<Class, SHProxyTypeJunction*> SHProxyJunctionTree;

NS_ASSUME_NONNULL_BEGIN

@interface SHViewController (SHAppearance) <UIAppearance>
@property (class, readonly, nonatomic) SHProxyJunctionTree *tree;
@property (strong, nonatomic) UIColor *viewBackgroundColor UI_APPEARANCE_SELECTOR;
@end

NS_ASSUME_NONNULL_END
