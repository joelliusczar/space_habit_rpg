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
		if(nil == _backend) {
			_backend = [NSMutableDictionary dictionary];
		}
	}
	return self;
}


-(NSInteger)getAndIncrementCountForSector:(NSString *)sectorName {
	NSNumber *tmp = (NSNumber *)self.backend[sectorName];
	NSInteger count = nil == tmp ? tmp.integerValue : 0;
	NSInteger incr = count++;
	self.backend[sectorName] = @(incr);
	return count;
}


-(void)saveToFile {
	NSError *error = nil;
	[self.backend writeToURL:self.saveUrl error:&error];
}


@end
