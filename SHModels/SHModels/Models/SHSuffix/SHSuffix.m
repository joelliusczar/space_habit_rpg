//
//  SHSuffix+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSuffix.h"

static NSString* BACKEND_KEY = @"suffix_tracker";

@interface SHSuffix ()
@property (strong, nonatomic) NSMutableDictionary *backend;
@property (strong, nonatomic) NSURL *saveUrl;
@end

@implementation SHSuffix
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [resourceUtil getPListMutableDict:BACKEND_KEY];
		_resourceUtil = resourceUtil;
		if(nil == _backend) {
			_backend = [NSMutableDictionary dictionary];
		}
	}
	return self;
}


-(NSInteger)getAndIncrementCountForSector:(NSString *)sectorName {
	NSNumber *tmp = (NSNumber *)self.backend[sectorName];
	NSInteger count = tmp.integerValue;
	NSInteger incr = count + 1;
	self.backend[sectorName] = @(incr);
	return count;
}


-(void)saveToFile {
	[self.resourceUtil saveDict:self.backend toFile:self.saveUrl];
}


@end
