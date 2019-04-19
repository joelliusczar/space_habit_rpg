//
//  SHView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHCommon/SHInterceptorProtocol.h>
#import "SHViewProtocol.h"


@interface SHView : UIView
@property (weak,nonatomic) UIView *mainView;
@property (weak,nonatomic) UIView *holderView;
@property (strong,nonatomic) id<SHInterceptorProtocol> interceptor;
-(instancetype)initEmpty;
-(void)changeBackgroundColorTo:(UIColor *)color;
-(UIView *)loadDefaultXib;
-(void)setupCustomOptions;
@end
