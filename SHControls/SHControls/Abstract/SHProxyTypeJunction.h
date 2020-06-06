//
//  SHProxyTypeJunction.h
//  SHControls
//
//  Created by Joel Pridgen on 4/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHAppearanceProxyTypedefs.h"
#import "SHViewController.h"
#import "SHViewControllerAppearanceProxy.h"
@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface SHProxyTypeJunction : NSObject
@property (strong, nonatomic) SHHierarchyDict *classListDict;
@property (strong, nonatomic) SHTraitProxyDict *traitDict;
@property (strong, nonatomic) SHHierarchyTraitDict *classListTraitDict;
@property (strong, nonatomic) SHViewControllerAppearanceProxy *singleProxy;
-(instancetype)initWithReference:(SHViewController *)reference;
-(SHViewControllerAppearanceProxy *)getMostSpecificProxy:(SHViewController *)viewController;
-(SHViewControllerAppearanceProxy *)getMostSpecificProxy:(SHViewController *)viewController
	with:(UITraitCollection*)traits;
@end

NS_ASSUME_NONNULL_END
