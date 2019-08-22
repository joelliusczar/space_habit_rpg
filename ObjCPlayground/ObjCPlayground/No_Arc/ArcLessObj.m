//
//	ArcLessObj.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 3/9/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "ArcLessObj.h"

@implementation ArcLessObj
static ArcLessObj* cGet(){
	ArcLessObj* instance = [[ArcLessObj alloc] init];
	instance.nombre = @"extraNew;";
	return instance;
}


static ArcLessObj* new_cGoRelease() NS_RETURNS_RETAINED{
	ArcLessObj* instance = [[ArcLessObj alloc] init];
	instance.nombre = @"getRelease;";
	return instance;
}

+(instancetype)new{
	ArcLessObj* instance = [[ArcLessObj alloc] init];
	instance.nombre = @"new;";
	return instance;
}

+(instancetype)extraNew{
	return cGet();
}


+(instancetype)newExtraRelease{
	ArcLessObj* instance = new_cGoRelease();
	return instance;
}


+(instancetype)otherNew{
	ArcLessObj* instance = [[ArcLessObj alloc] init];
	instance.nombre = @"Other new;";
	return instance;
}

-(void)dealloc{
	NSLog(@"Dealloc that shit! <%@> %@",self,self.nombre);
	[self.nombre release];
	[super dealloc];
}

-(NSString*)debugDescription{
	return [NSString stringWithFormat:@"<%@> nombre: %@",self,self.nombre];
}

-(void)doATrick{
	NSLog(@"look at that!");
}
@end
