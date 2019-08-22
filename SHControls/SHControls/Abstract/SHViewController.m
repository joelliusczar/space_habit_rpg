//
//	SHViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/29/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
#import <SHCommon/SHInterceptor.h>

@interface SHViewController ()

@end

@implementation SHViewController

-(id<SHInterceptorProtocol>)interceptor{
	if(nil==_interceptor){
		_interceptor = [[SHInterceptor alloc] init];
	}
	return _interceptor;
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.view.backgroundColor = color;
}

@end
