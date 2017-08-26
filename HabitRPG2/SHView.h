//
//  SHView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHView : UIView
@property (weak,nonatomic) UIView *mainView;
@property (weak,nonatomic) UIView *holderView;
-(instancetype)initEmpty;
-(void)changeBackgroundColorTo:(UIColor *)color;
-(UIView *)loadDefaultXib;
@end
