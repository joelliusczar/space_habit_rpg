//
//  rateSetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_RateSetterDelegate <NSObject>
-(void)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event;
@end
