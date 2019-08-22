//
//	Watcher.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 4/12/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "Watcher.h"

@implementation Watcher


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
 change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
	(void)object;
	(void)change;
	(void)context;
	NSLog(@"%@",keyPath);
	if([keyPath isEqualToString:@"watched"]){
		NSLog(@"%@",@"For the watch");
	}
}


@end
