//
//  P_ImportanceSlidersDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "P_CommonDelegate.h"

@class ImportanceSliderView;

@protocol P_ImportanceSlidersDelegate <NSObject,P_CommonDelegate>
-(void)importanceSlider:(ImportanceSliderView *)sliderView sld_valueChanged_action:(UISlider *)sender
                             forEvent:(UIEvent *)event;

@end
