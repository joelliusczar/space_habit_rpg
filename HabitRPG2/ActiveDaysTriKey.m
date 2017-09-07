//
//  ActiveDaysTriKey.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ActiveDaysTriKey.h"

@implementation ActiveDaysTriKey

-(instancetype)initWithRateType:(RateType)rateType key:(NSString *)key index:(NSInteger)index{
    if(self = [super init]){
        _rateType = rateType;
        _key = key;
        _index = index;
    }
    return self;
}

@end
