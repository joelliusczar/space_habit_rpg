//
//  SHRateTypeSelectorDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHGlobal/SHConstants.h>
#import "SHEventInfo.h"

@protocol RateTypeSelectorDelegateProtocol <NSObject>
-(void)updateRateType:(SHRateType)rateType with:(SHEventInfo *)eventInfo;
@end
