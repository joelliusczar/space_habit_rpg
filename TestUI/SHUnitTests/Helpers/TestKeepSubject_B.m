//
//  TestKeepObject_B.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/14/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestKeepSubject_B.h"

@implementation TestKeepSubject_B

-(NSInteger)callGetA2{
	return [self.delegateA2 get52] *2;
}

-(NSInteger)callGetB2{
	return [self.delegateB2 get65] *2;
}


@end
