//
//  SHIconBuilder.h
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#if TARGET_OS_MACCATALYST || TARGET_OS_IOS
@import UIKit;




NS_ASSUME_NONNULL_BEGIN

@interface SHIconBuilder : NSObject
@property (class, strong, nonatomic) UIColor *defaultColor;
@property (class, strong, nonatomic) UIColor *defaultBackgroundColor;
@property (class, strong, nonatomic) UIColor *defaultTertiaryColor;
@property (class, assign, nonatomic) CGSize defaultSize;
@property (class, assign, nonatomic) CGFloat defaultThickness;

@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *backgroundColor;
@property (strong, nonatomic) UIColor *tertiaryColor;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat thickness;


-(UIImage *)drawX;
-(UIImage *)drawCheck;
-(UIImage *)drawPlus;
-(UIImage *)drawMinus;
-(UIImage *)drawForwardArrow;
-(UIImage *)drawBackArrow;
-(UIImage *)drawForwardArrow2;
-(UIImage *)drawBackArrow2;
-(UIImage *)drawBlank;
-(UIImage *)drawPie:(CGFloat)percent;
@end

NS_ASSUME_NONNULL_END

#endif

