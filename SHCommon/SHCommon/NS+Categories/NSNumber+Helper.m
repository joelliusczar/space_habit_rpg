//
//  NSNumber+Helpers.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSNumber+Helper.h"

@implementation NSNumber (Helper)

-(NSNumber *)plusInteger:(NSInteger)num{
	NSInteger intForm = self.integerValue;
	return [NSNumber numberWithInteger:intForm + num];
}

@end
