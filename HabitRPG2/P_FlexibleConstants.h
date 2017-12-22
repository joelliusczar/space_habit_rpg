//
//  P_FlexibleConstants.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 12/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_FlexibleConstants <NSObject>
@property (readonly,nonatomic) NSUInteger DAYS_IN_WEEK;
@property (readonly,strong,nonatomic) NSArray<NSString *> *WEEKDAY_KEYS;
@end
