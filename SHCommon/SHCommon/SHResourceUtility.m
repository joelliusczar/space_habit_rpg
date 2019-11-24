//
//  SHResourceUtility.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHResourceUtility.h"

@implementation SHResourceUtility

-(instancetype)initWithBundle:(NSBundle*)bundle {
	if(self = [super init]) {
		_bundle = bundle;
	}
	return self;
}

-(NSURL*)getFileUrl:(NSString*)fileName {
	NSAssert(self.bundle, @"bundle is null");
	NSURL *fileUrl = [self.bundle URLForResource:fileName withExtension:@"plist"];
	NSAssert(fileUrl,@"file path for plist was null or empty");
	return fileUrl;
}


-(NSURL*)getURLMutableFile:(NSString*)fileName {
	NSString *homeDir = NSHomeDirectory();
	NSString *filePath = [homeDir stringByAppendingPathComponent:fileName];
	NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
	return fileUrl;
}


-(NSDictionary *)getPListDict:(NSString*)fileName{
	NSURL *fileUrl = [self getFileUrl:fileName];
	NSError *error = nil;
	return [NSDictionary dictionaryWithContentsOfURL:fileUrl error:&error];
}


-(NSMutableDictionary*)getPListMutableDict:(NSString*)fileName {
	NSURL *fileUrl = [self getURLMutableFile:fileName];
	NSError *error = nil;
	NSDictionary *data = [NSMutableDictionary dictionaryWithContentsOfURL:fileUrl error:&error];;
	return [NSMutableDictionary dictionaryWithDictionary:data];
}

-(NSArray *)getPListArray:(NSString*)fileName{
	NSURL *fileUrl = [self getFileUrl:fileName];
	NSError *error = nil;
	return [NSArray arrayWithContentsOfURL:fileUrl error:&error];
}



@end
