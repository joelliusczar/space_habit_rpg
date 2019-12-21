//
//  SHRateTypeSelectorDelegateProtocol.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHEventInfo.h"
@import Foundation;
@import SHCommon;


@protocol SHRateTypeSelectorDelegateProtocol <NSObject>
-(void)updateRateType:(SHRateType)rateType with:(SHEventInfo *)eventInfo;
@end
