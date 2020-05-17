//
//  House.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "House.h"

@implementation House

-(void)returnsNothing{
	NSLog(@"%@",@"nothing");
}


-(NSInteger)getFive{
	return 5;
}

-(void)dealloc{
	NSLog(@"%@",@"Deallocating, motherfucker!");
}

-(void)watchSelf {
	[self addObserver:self forKeyPath:@"couch" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
 change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
	(void)object;
	(void)change;
	(void)context;
	NSLog(@"%@",keyPath);
	if([keyPath isEqualToString:@"couch"]){
		NSLog(@"The couch is %@",self.couch);
	}
}

@end


@implementation FakeHouse

-(void)returnsNothing{
	NSLog(@"%@",@"nothing");
}


-(NSInteger)getFive{
	return 5;
}

-(void)dealloc{
	NSLog(@"%@",@"Deallocating, motherfucker!");
}

@end
