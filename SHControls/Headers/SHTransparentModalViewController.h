//
//  SHTransparentModalViewController.h
//  SHControls
//
//  Created by Joel Pridgen on 3/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import "SHViewController.h"
#import "SHModalContentProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHTransparentModalViewController : SHViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;
@property (weak, nonatomic) IBOutlet UIView *modalContentView;
@property (strong, nonatomic) SHViewController<SHModalContentProtocol> *modalContentViewController;
-(instancetype)initWithModalViewController:(SHViewController<SHModalContentProtocol> *)modalViewController;
@end

NS_ASSUME_NONNULL_END
