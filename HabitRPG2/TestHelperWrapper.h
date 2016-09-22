//
//  TestHelperWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/21/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonUtilitiesMock.h"
#import "DailyHelperMock.h"

@interface TestHelperWrapper : NSObject
@property (nonatomic,strong) CommonUtilitiesMock *commonHelper;
@property (nonatomic,strong) DailyHelperMock *dailyHelper;
@end
