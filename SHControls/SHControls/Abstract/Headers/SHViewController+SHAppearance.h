//
//  SHViewController+SHAppearance.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHViewController.h"
#import "SHVCProxyContainer.h"

@class SHVCProxyContainer;

NS_ASSUME_NONNULL_BEGIN

@interface SHViewController (SHAppearance) <UIAppearance>
@property (class, readonly, nonatomic) SHVCProxyContainer *proxyContainer;
@property (strong, nonatomic) UIColor *viewBackgroundColor UI_APPEARANCE_SELECTOR;
@end

NS_ASSUME_NONNULL_END
