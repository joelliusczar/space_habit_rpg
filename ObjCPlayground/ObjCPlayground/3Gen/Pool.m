//
//	Pool.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 2/26/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "Pool.h"

@implementation Pool

-(void)printVolume{
	NSLog(@"Water");
}

-(void)someClassStuff:(Pool *)ourGuy{
	if([ourGuy isMemberOfClass:self.class]){
		NSLog(@"Yes self: %@ is ourGuy:%@",self.class, ourGuy.class);
	}
	else{
		NSLog(@"No self: %@ is not ourGuy:%@",self.class, ourGuy.class);
	}
		
	if([ourGuy isKindOfClass:self.class]){
		NSLog(@" self: %@ is kind of ourGuy:%@",self.class, ourGuy.class);
	}
	else{
		NSLog(@" self: %@ is not kind of ourGuy:%@",self.class, ourGuy.class);
	}
}

@end
