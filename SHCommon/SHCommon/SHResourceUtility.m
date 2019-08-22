//
//  SHResourceUtility.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHResourceUtility.h"

@implementation SHResourceUtility 

-(NSDictionary *)getPListDict:(NSString*)fileName withBundle:(nonnull NSBundle *)bundle{
	NSString *filePath = [bundle pathForResource:fileName ofType:@"plist"];
	NSAssert(filePath,@"file path for plist was null or empty");
	return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

-(NSArray *)getPListArray:(NSString*)fileName withBundle:(nonnull NSBundle *)bundle{
	NSString *filePath = [bundle pathForResource:fileName ofType:@"plist"];
	NSAssert(filePath,@"file path for plist was null or empty");
	return [NSArray arrayWithContentsOfFile:filePath];
}

@end
