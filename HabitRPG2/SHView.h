//
//  SHView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_Interceptor.h"
#import "P_SHView.h"


@interface SHView : UIView
@property (weak,nonatomic) UIView *mainView;
@property (weak,nonatomic) UIView *holderView;
@property (strong,nonatomic) id<P_Interceptor> interceptor;
-(instancetype)initEmpty;
-(void)changeBackgroundColorTo:(UIColor *)color;
-(UIView *)loadDefaultXib;
-(void)setupCustomOptions;
@end
