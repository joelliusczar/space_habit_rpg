//
//  TestKeepSubject.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestKeepProtocol_A.h"
#import "TestKeepProtocol_B.h"

@interface TestKeepObject : NSObject<TestKeepProtocol_A,TestKeepProtocol_B>

@end
