//
//  rateSetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CommonDelegate.h"
#import "SHSwitch.h"
#import "SHEventInfo.h"

@protocol P_RateSetterDelegate <NSObject,P_CommonDelegate>
-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo;
@end
