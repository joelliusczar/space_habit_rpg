//
//  ParentMan.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ParentMan.h"

static NSString *_name = nil;

@implementation ParentMan

+(NSString*)name {
	return _name;
}

+(void)setName:(NSString *)name {
	_name = name;
}

-(instancetype)init{
	if(self = [super init]){
		_contrlNum = 7;
	}
	return self;
}

+(instancetype)newParentMan{
	ParentMan *pm = [[ParentMan alloc] init];
	return pm;
}

-(instancetype)initTwo{
	if(self = [super init]){
		[self writeOverLocal];
		[self writeOverPublic];
	}
	return self;
}

-(void)writeOverLocal{
	NSLog(@"%@",@"L-1");
}

-(void)writeOverPublic{
	NSLog(@"%@",@"P-1");
}

-(void)nothing{}

@end
