//
//  ControlController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControlController : UIViewController
@property (weak,nonatomic) UIView *container;
-(instancetype)initDefault;
-(void)setBackgroundColor:(UIColor *)color;
@end
