//
//  TestKeepObject_A.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestKeepSubject_A.h"

@implementation TestKeepSubject_A

-(void)setDelegateA:(id<TestKeepProtocol_A>)delegateA{
    _delegateA = delegateA;
}

-(void)setDelegateB:(id<TestKeepProtocol_B>)delegateB{
    _delegateB = delegateB;
}

-(void)setDelegateC:(id<TestKeepProtocol_C>)delegateC{
    _delegateC = delegateC;
}

-(NSInteger)callGetA{
    return [self.delegateA get52] +self.changer;
}

-(NSInteger)callGetB{
    return [self.delegateB get65] +self.changer;
}

-(NSInteger)callGetC{
    return [self.delegateC get19] +self.changer;
}

@end
