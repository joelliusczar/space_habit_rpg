//
//  TestHelperWrapper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "TestHelperWrapper.h"

@implementation TestHelperWrapper

@synthesize commonHelper = _commonHelper;
-(CommonUtilitiesMock *)commonHelper{
    if(_commonHelper == nil){
        _commonHelper = [[CommonUtilitiesMock alloc]init];
    }
    return _commonHelper;
}

@synthesize dailyHelper = _dailyHelper;
-(DailyHelperMock *)dailyHelper{
    if(_dailyHelper == nil){
        _dailyHelper = [[DailyHelperMock alloc]init];
    }
    return _dailyHelper;
}


@end
