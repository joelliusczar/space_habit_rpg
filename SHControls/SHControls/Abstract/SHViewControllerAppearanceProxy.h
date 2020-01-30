//
//  SHViewControllerAppearanceProxy.h
//  SHControls
//
//  Created by Joel Pridgen on 1/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import <SHControls/SHControls.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHViewControllerAppearanceProxy : SHViewController
-(instancetype)initWithReference:(SHViewController *)reference;
-(void)applyPropertyChangesToTarget:(SHViewController*)target;
@end

NS_ASSUME_NONNULL_END
