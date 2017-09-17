//
//  TestKeepObject_B.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestKeepProtocol_A.h"
#import "TestKeepProtocol_B.h"

@interface TestKeepSubject_B : NSObject
@property (strong,nonatomic) id<TestKeepProtocol_A> delegateA2;
@property (strong,nonatomic) id<TestKeepProtocol_B> delegateB2;
-(NSInteger)callGetA2;
-(NSInteger)callGetB2;
@end
