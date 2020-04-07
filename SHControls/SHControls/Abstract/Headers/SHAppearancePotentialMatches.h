//
//  SHAppearancePotentialMatch.h
//  SHControls
//
//  Created by Joel Pridgen on 1/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHVCProxyContainer.h"
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface SHAppearancePotentialMatches : NSObject
@property (strong, nonatomic) SHVCProxyContainer *proxyContainer;
@property (weak, nonatomic) SHViewController *viewControllerOrChild;
-(instancetype)initWithProxyContainer:(SHVCProxyContainer*)proxyContainer
	withSHViewController:(SHViewController*)viewController;
-(nullable SHViewControllerAppearanceProxy*)getMatchIfAvailable;
@end

NS_ASSUME_NONNULL_END
