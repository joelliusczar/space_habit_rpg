//
//  SHTestResourceUtil.m
//  SHTestCommon
//
//  Created by Joel Pridgen on 2/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHTestResourceUtil.h"

@implementation SHTestResourceUtil

-(instancetype)initWithResourceUtil:(SHResourceUtility *)resourceUtil {
	if(self == [super init]) {
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(NSMutableDictionary *)mockFileSystem {
	if(nil == _mockFileSystem) {
		_mockFileSystem = [NSMutableDictionary dictionary];
	}
	return _mockFileSystem;
}


-(void)erase:(nonnull NSString *)fileKey {
	[self.mockFileSystem removeObjectForKey:fileKey];
}


-(nonnull NSURL *)getFileUrl:(nonnull NSString *)fileKey {
	return [self.resourceUtil getFileUrl:fileKey];
}


-(nonnull NSArray *)getPListArray:(nonnull NSString *)fileKey {
	return [self.resourceUtil getPListArray:fileKey];
}


-(nonnull NSDictionary *)getPListDict:(nonnull NSString *)fileKey {
	return [self.resourceUtil getPListDict:fileKey];
}


- (nonnull NSMutableArray *)getPListMutableArray:(nonnull NSString *)fileKey {
	return self.mockFileSystem[fileKey];
}


- (nonnull NSMutableDictionary *)getPListMutableDict:(nonnull NSString *)fileKey {
	return self.mockFileSystem[fileKey];
}


- (nonnull NSURL *)getURLMutableFile:(nonnull NSString *)fileKey {
	return [self.resourceUtil getURLMutableFile:fileKey];
}


-(void)saveDict:(NSDictionary *)dict toFile:(NSURL*)fileUrl {
	self.mockFileSystem[fileUrl.absoluteString] = dict;
}

@end
