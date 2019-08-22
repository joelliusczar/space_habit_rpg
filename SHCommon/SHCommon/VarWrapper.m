//
//  SHVarWrapper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHVarWrapper.h"
#import <SHGlobal/SHCommonTypeDefs.h>

@implementation SHVarWrapper


-(instancetype)init:(id)item, ...{
	if(self = [self init]){
		_item = item;
		va_list args;
		va_start(args,item);
		id arg = nil;
		NSString *baseString = @"setItem%d:";
		int count = 2;
		while((arg = va_arg(args,id))){
			NSString *propName = [NSString stringWithFormat:baseString,count];
			SEL selector = NSSelectorFromString(propName);
			if([self respondsToSelector:selector]){
				shSetter impl = (shSetter)[self methodForSelector:selector];
				impl(self,selector,arg);
			}
			else{
				break;
			}
		}
		va_end(args);
		
	}
	return self;
}


-(NSUInteger)hash{
	if([self.item respondsToSelector:@selector(hash)]){
		return [self.item hash];
	}
	/*Objective c's generics only work with object type so we shouldn't even
	 have to worry about code trying to call hash on things that don't have that 
	 property.
	*/
	@throw [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:@"The code should not have been able to get here."
								   userInfo:nil];
}

-(BOOL)isEqual:(id)object{
	SHVarWrapper *obj = (SHVarWrapper *)object;
	return [self.item isEqual:obj.item];
}

@end


@implementation PairWrapper
@end
