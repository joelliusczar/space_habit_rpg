//
//  SHStatusBar.h
//  SHControls
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHStatusBar : UIView
@property (strong,nonatomic) IBInspectable UIColor *fullnessColor;
@property (strong,nonatomic) IBInspectable UIColor *emptyColor;
@property (assign,nonatomic) IBInspectable double percent;
@end

NS_ASSUME_NONNULL_END
