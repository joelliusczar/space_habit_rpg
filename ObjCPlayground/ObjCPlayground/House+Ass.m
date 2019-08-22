//
//  House+Ass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "House+Ass.h"
#import <objc/runtime.h>

@implementation House (Ass)
+(NSInteger)ghostNum{
	return ((NSNumber *)objc_getAssociatedObject(self,@selector(ghostNum))).integerValue;
}

+(void)setGhostNum:(NSInteger)num{
	objc_setAssociatedObject(self,@selector(ghostNum),[NSNumber numberWithInteger:num],OBJC_ASSOCIATION_ASSIGN);
}
@end
