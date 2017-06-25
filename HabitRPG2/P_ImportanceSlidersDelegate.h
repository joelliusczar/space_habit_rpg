//
//  P_ImportanceSlidersDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol P_ImportanceSlidersDelegate <NSObject>
-(void)urgencySld_valueChanged_action:(UISlider *)sender
                             forEvent:(UIEvent *)event;

-(void)difficultySld_valueChanged_action:(UISlider *)sender
                             forEvent:(UIEvent *)event;
@end
