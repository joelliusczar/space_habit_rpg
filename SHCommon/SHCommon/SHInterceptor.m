//
//  SHInterceptor.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHInterceptor.h"

@implementation SHInterceptor

-(void)callVoidWrapped:(shWrapReturnVoid)callMe withInfo:(id)info{
	[SHInterceptor callVoidWrapped:callMe withInfo:info];
}


+(void)callVoidWrapped:(shWrapReturnVoid)callMe withInfo:(id)info{
	(void)info;
	//[self handleInterceptedInfo:info];
	//NSArray<NSString *> *callStack = NSThread.callStackSymbols;
	callMe();
}


-(BOOL)callBoolWrapped:(shWrapReturnBool)callMe withInfo:(id)info{
	(void)info;
	@try{
		return callMe();
	}
	@catch(NSException *ex){
		NSLog(@"%@",@"got em bool");
	}
	
}

+(void)handleInterceptedInfo:(id)info{
	if(nil==info){}
	else if([info isKindOfClass:NSString.class]){
		//NSLog(@"%@",info);
	}
	else if([info isKindOfClass:NSDictionary.class]){}
	else if([info isKindOfClass:NSArray.class]){}
}

@end
