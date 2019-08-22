//
//	FromCFunc.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 3/8/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "FromCFunc.h"

@implementation FromCFunc

static FromCFunc* cGet(){
	FromCFunc* instance = [[FromCFunc alloc] init];
	instance.nombre = @"extraNew;";
	return instance;
}


static FromCFunc* new_cGoRelease() NS_RETURNS_RETAINED{
	FromCFunc* instance = [[FromCFunc alloc] init];
	instance.nombre = @"getRelease;";
	return instance;
}

+(instancetype)new{
	FromCFunc* instance = [[FromCFunc alloc] init];
	instance.nombre = @"new;";
	return instance;
}

+(instancetype)extraNew{
	return cGet();
}


+(instancetype)newExtraRelease{
	FromCFunc* instance = new_cGoRelease();
	return instance;
}


+(instancetype)otherNew{
	FromCFunc* instance = [[FromCFunc alloc] init];
	instance.nombre = @"Other new;";
	return instance;
}

-(void)dealloc{
	NSLog(@"Dealloc that shit! <%@> %@",self,self.nombre);
}

-(NSString*)debugDescription{
	return [NSString stringWithFormat:@"<%@> nombre: %@",self,self.nombre]; 
}

-(void)doATrick{
	NSLog(@"look at that!");
}

@end
