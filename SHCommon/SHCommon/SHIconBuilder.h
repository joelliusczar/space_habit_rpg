//
//  SHIconBuilder.h
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;




NS_ASSUME_NONNULL_BEGIN

@interface SHIconBuilder : NSObject
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat thickness;
-(instancetype)initWithColor:(UIColor *)color
	withBackgroundColor:(UIColor*)backgroundColor
	withSize:(CGSize)size
	withThickness:(CGFloat)thickness;
-(UIImage *)drawX;
-(UIImage *)drawCheck;
-(UIImage *)drawPlus;
-(UIImage *)drawMinus;
-(UIImage *)drawForwardArrow;
-(UIImage *)drawBackArrow;
@end

NS_ASSUME_NONNULL_END

