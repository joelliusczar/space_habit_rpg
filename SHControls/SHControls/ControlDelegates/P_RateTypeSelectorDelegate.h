//
//  P_RateTypeSelectorDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHGlobal/Constants.h>
#import "SHEventInfo.h"

@protocol P_RateTypeSelectorDelegate <NSObject>
-(void)updateRateType:(RateType)rateType with:(SHEventInfo *)eventInfo;
@end
