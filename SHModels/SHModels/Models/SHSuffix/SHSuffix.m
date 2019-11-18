//
//  SHSuffix+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSuffix.h"

@interface SHSuffix ()
@property (strong, nonatomic) NSMutableDictionary *backend;
@property (strong, nonatomic) NSURL *saveUrl;
@end

@implementation SHSuffix
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getFileUrl:@"suffix_tracker"];
		_backend = [resourceUtil getPListMutableDict:@"suffix_tracker"];
	}
	return self;
}


-(NSInteger)getAndIncrementCountForSector:(NSString *)sectorName {
	NSNumber *tmp = (NSNumber *)self.backend[sectorName];
	NSInteger count = tmp ? tmp.integerValue : 0;
	NSInteger incr = count++;
	self.backend[sectorName] = @(incr);
	return count;
}


-(void)saveToFile {
	NSError *error = nil;
	[self.backend writeToURL:self.saveUrl error:&error];
}


@end
