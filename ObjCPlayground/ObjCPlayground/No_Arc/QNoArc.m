//
//	QNoArc.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 4/11/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "QNoArc.h"

@implementation QNoArc{
	House *obj;
}


-(void)setInst{
	obj = [House new];
	NSLog(@"%@",obj);
}


-(void)setAndKeep{
	obj = [[House new] retain];
	NSLog(@"%@",obj);
}

-(void)checkInst{
	NSLog(@"And then: %@",obj);
	[obj release];
}



@end
