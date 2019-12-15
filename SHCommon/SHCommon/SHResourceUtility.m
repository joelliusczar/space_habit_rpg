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

-(NSURL*)getFileUrl:(NSString*)fileKey {
	NSAssert(self.bundle, @"bundle is null");
	NSURL *fileUrl = [self.bundle URLForResource:fileKey withExtension:@"plist"];
	NSAssert(fileUrl,@"file path for plist was null or empty");
	return fileUrl;
}


-(NSURL*)getURLMutableFile:(NSString*)fileKey {
	NSString *homeDir = NSHomeDirectory();
	NSString *filePath = [homeDir stringByAppendingPathComponent:fileKey];
	NSURL *fileUrl = [NSURL fileURLWithPath:filePath isDirectory:NO];
	return fileUrl;
}


-(NSDictionary *)getPListDict:(NSString*)fileKey{
	NSURL *fileUrl = [self getFileUrl:fileKey];
	NSError *error = nil;
	return [NSDictionary dictionaryWithContentsOfURL:fileUrl error:&error];
}


-(NSMutableDictionary*)getPListMutableDict:(NSString*)fileKey {
	NSURL *fileUrl = [self getURLMutableFile:fileKey];
	NSError *error = nil;
	NSDictionary *data = [NSMutableDictionary dictionaryWithContentsOfURL:fileUrl error:&error];
	if(error) return nil;
	return [NSMutableDictionary dictionaryWithDictionary:data];
}


-(NSMutableArray*)getPListMutableArray:(NSString*)fileKey {
	NSURL *fileUrl = [self getURLMutableFile:fileKey];
	NSError *error = nil;
	NSArray *data = [NSMutableArray arrayWithContentsOfURL:fileUrl error:&error];
	if(error) return nil;
	return [NSMutableArray arrayWithArray:data];
}


-(NSArray *)getPListArray:(NSString*)fileKey{
	NSURL *fileUrl = [self getFileUrl:fileKey];
	NSError *error = nil;
	return [NSArray arrayWithContentsOfURL:fileUrl error:&error];
}


-(void)erase:(NSString*)fileKey {
	NSURL *fileUrl = [self getFileUrl:fileKey];
	NSError *error = nil;
	NSFileManager *fm = [NSFileManager defaultManager];
	[fm removeItemAtURL:fileUrl error:&error];
	if(error) {
		@throw [NSException exceptionWithName:@"fileDelete"
			reason:@"File failed to delete" userInfo:error.userInfo];
	}
}

@end
