//
//  SHTransparentModalViewController.h
//  SHControls
//
//  Created by Joel Pridgen on 3/27/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//


#import "SHViewController.h"
#import "SHModalContentProtocol.h"
#import "SHModalPresenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHTransparentModalViewController : SHViewController<SHModalPresenterProtocol>
@property (weak, nonatomic) IBOutlet UIView *modalContentView;
@property (strong, nonatomic) SHViewController<SHModalContentProtocol> *modalContentViewController;
-(instancetype)initWithModalViewController:(SHViewController<SHModalContentProtocol> *)modalViewController;
@end

NS_ASSUME_NONNULL_END
