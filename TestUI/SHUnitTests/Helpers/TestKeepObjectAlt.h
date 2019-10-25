//
//  TestKeepObjectAlt.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "TestKeepProtocol_A.h"
#import "TestKeepProtocol_B.h"
#import "TestKeepProtocol_C.h"

@interface TestKeepObjectAlt : NSObject<TestKeepProtocol_A,TestKeepProtocol_B,TestKeepProtocol_C>

@end
