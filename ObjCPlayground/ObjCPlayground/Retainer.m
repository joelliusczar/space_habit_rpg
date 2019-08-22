//
//	Retainer.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 11/23/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Retainer.h"

@implementation Retainer
-(void)dealloc{
	_r = nil;
	NSLog(@"deallocating r");
}

@synthesize obj = _obj;
-(NSObject*)obj{
	return _obj;
}

-(void)setObj:(NSObject *)obj{
	_obj = obj;
}
@end
