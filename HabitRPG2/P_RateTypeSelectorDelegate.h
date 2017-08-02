//
//  P_RateTypeSelectorDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_RateTypeSelectorDelegate <NSObject>
-(void)updateRateType:(int)rateType;
@end
