//
//  rateSetterDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "SHCommonDelegateProtocol.h"
#import "SHSwitch.h"
#import "SHEventInfo.h"

@protocol SHRateSetterDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)rateStep_valueChanged_action:(SHEventInfo *)eventInfo;
@end
