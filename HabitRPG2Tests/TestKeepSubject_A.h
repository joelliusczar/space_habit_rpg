//
//  TestKeepObject_A.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestKeepProtocol_A.h"
#import "TestKeepProtocol_B.h"
#import "TestKeepProtocol_C.h"

@interface TestKeepSubject_A : NSObject
@property (strong,nonatomic) id<TestKeepProtocol_A> delegateA;
@property (strong,nonatomic) id<TestKeepProtocol_B> delegateB;
@property (strong,nonatomic) id<TestKeepProtocol_C> delegateC;
@property (assign,nonatomic) NSInteger changer;
-(NSInteger)callGetA;
-(NSInteger)callGetB;
-(NSInteger)callGetC;
@end
