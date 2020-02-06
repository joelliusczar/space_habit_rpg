//
//  SHViewController+SHAppearance.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHViewController.h"
#import "SHVCAppearanceProxyContainer.h"

@class SHVCAppearanceProxyContainer;

NS_ASSUME_NONNULL_BEGIN

@interface SHViewController (SHAppearance) <UIAppearance>
@property (class, readonly, nonatomic) SHVCAppearanceProxyContainer *proxyContainer;
@end

NS_ASSUME_NONNULL_END
