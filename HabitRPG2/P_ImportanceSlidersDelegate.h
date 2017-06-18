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
-(void)urgencyLvlChanged:(UISlider *)sender passedEvent:(UIEvent *)e;
-(void)difficultyLvlChanged:(UISlider *)sender passedEvent:(UIEvent *)e;
@end
