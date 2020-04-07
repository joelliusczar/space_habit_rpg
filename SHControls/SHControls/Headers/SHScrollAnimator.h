//
//  SHScrollAnimator.h
//  SHControls
//
//  Created by Joel Pridgen on 11/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import UIKit;

typedef void (^animationBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SHScrollAnimator : NSObject<CAAnimationDelegate>
@property (strong, nonatomic) UIView *scrollContent;
@property (assign, nonatomic) CGFloat scrollLength;
@property (copy, nonatomic) void (^onAnimationFinish)(void);
-(instancetype)initWithScrollView:(UIView *)scrollContent
	withScrollLength:(CGFloat)scrollLength;
-(void)startAnimation;
-(void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
