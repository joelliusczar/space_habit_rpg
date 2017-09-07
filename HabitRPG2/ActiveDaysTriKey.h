//
//  ActiveDaysTriKey.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@interface ActiveDaysTriKey : NSObject
@property (assign,nonatomic) RateType rateType;
@property (strong,nonatomic) NSString *key;
@property (assign,nonatomic) NSInteger index;
-(instancetype)initWithRateType:(RateType)rateType key:(NSString *)key index:(NSInteger)index;
@end
