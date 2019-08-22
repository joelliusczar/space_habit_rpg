//
//	Indexable.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/12/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Indexable.h"

@implementation Indexable

-(id)objectAtIndexedSubscript:(NSUInteger)idx{
	(void)idx;
	NSLog(@"%@",@"Yo we're in an index");
	return nil;
}


-(id)objectForKeyedSubscript:(id)key{
	(void)key;
	NSLog(@"%@",@"Yom we're in a dictionary subscript!");
	return nil;
}

@end
