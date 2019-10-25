//
//  SHImportanceSlidersDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHCommonDelegateProtocol.h"
#import "SHEventInfo.h"
@import Foundation;
@import UIKit;

@class SHImportanceSliderView;

@protocol SHImportanceSlidersDelegateProtocol <NSObject,SHCommonDelegateProtocol>
-(void)sld_valueChanged_action:(SHEventInfo *)eventInfo;

@end
