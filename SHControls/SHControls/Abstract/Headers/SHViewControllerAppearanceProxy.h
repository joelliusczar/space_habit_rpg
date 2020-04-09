//
//  SHViewControllerAppearanceProxy.h
//  SHControls
//
//  Created by Joel Pridgen on 1/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHAppearanceProxyTypedefs.h"
#import "SHViewController.h"
@import SHCommon;



NS_ASSUME_NONNULL_BEGIN

@interface SHViewControllerAppearanceProxy : SHViewController
@property (strong, nonatomic) SHAppearanceHierarchy *classList;
@property (strong, nonatomic) UITraitCollection *traits;
-(instancetype)initWithReference:(SHViewController *)reference;
-(instancetype)initWithReference:(SHViewController *)reference
	withClassList:(SHAppearanceHierarchy *)classList
	withTraitCollection:(UITraitCollection *)traitCollection;
-(instancetype)initWithReference:(SHViewController *)reference
	withClassList:(SHAppearanceHierarchy *)classList;
-(instancetype)initWithReference:(SHViewController *)reference
	withTraitCollection:(UITraitCollection *)traitCollection;
-(void)applyPropertyChangesToTarget:(SHViewController*)target;
@end

NS_ASSUME_NONNULL_END

