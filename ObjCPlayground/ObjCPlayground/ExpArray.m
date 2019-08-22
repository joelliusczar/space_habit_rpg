//
//	ExpArray.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/11/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ExpArray.h"


@interface ExpArray ()
@property (strong,nonatomic) NSArray *backend;
@end

@implementation ExpArray

-(instancetype)init{
	if(self = [super init]){
		_hause = [[House alloc] init];
		_backend = [NSArray arrayWithObject:_hause];
	}
	return self;
}

-(NSUInteger)count{
	return self.backend.count;
}

-(id)objectAtIndex:(NSUInteger)index{
	NSLog(@"%@",@"Inside indexing!");
	return self.backend[index];
}

@end
