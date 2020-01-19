//
//	SHSector+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector.h"
@import SHCommon;

static SHSectorInfoDictionary *_sectorInfo;
static NSString* const BACKEND_KEY = @"sector_data";

@interface SHSector ()
@property (strong, nonatomic) NSMutableDictionary *backend;
@property (strong, nonatomic) NSURL *saveUrl;
@end

@implementation SHSector


+(SHSectorInfoDictionary*)sectorInfo{
	return _sectorInfo;
}


+(void)setSectorInfo:(SHSectorInfoDictionary *)sectorInfo{
	_sectorInfo = sectorInfo;
}


-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [resourceUtil getPListMutableDict:BACKEND_KEY];
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(instancetype)initEmptyWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil {
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_backend = [NSMutableDictionary dictionary];
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(instancetype)initWithDictionary:(NSMutableDictionary *)dict
	withResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil
{
	if(self = [super init]) {
		_saveUrl = [resourceUtil getURLMutableFile:BACKEND_KEY];
		_resourceUtil = resourceUtil;
		_backend = dict;
	}
	return self;
}


-(NSDictionary*)mapable{
	return [NSDictionary dictionaryWithDictionary:self.backend];
}


-(id)valueForUndefinedKey:(NSString *)key{
	(void)key;
	return nil;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
	(void)value;
	(void)key;
}


-(NSString *)fullName{
	NSString* name = [SHSector.sectorInfo getSectorName:self.sectorKey];
	return self.suffix.length ? [NSString stringWithFormat:@"%@ %@",name,self.suffix] : name;
}


-(NSString *)synopsis{
	return [SHSector.sectorInfo getSectorDescription:self.sectorKey];
}


-(NSString *)headline{
	return [NSString stringWithFormat:@"Your ship has arrived at \n%@",self.fullName];
}


-(NSInteger)lvl {
	NSNumber *num = (NSNumber*)self.backend[@"lvl"];
	NSInteger lvl = nil != num ? num.integerValue : 0;
	return lvl;
}


-(void)setLvl:(NSInteger)lvl {
	self.backend[@"lvl"] = @(lvl);
}


-(NSInteger)maxMonsters {
	NSNumber *num = (NSNumber*)self.backend[@"maxMonsters"];
	NSInteger maxMonsters = nil != num ? num.integerValue : 0;
	return maxMonsters;
}


-(void)setMaxMonsters:(NSInteger)maxMonsters {
	self.backend[@"maxMonsters"] = @(maxMonsters);
}


-(NSInteger)monstersKilled {
	NSNumber *num = (NSNumber*)self.backend[@"monstersKilled"];
	NSInteger monstersKilled = nil != num ? num.integerValue : 0;
	return monstersKilled;
}


-(void)setMonstersKilled:(NSInteger)monstersKilled {
	self.backend[@"monstersKilled"] = @(monstersKilled);
}


-(NSString*)suffix {
	NSString *suffix = (NSString*)self.backend[@"suffix"];
	return suffix;
}


-(void)setSuffix:(NSString*)suffix {
	self.backend[@"suffix"] = suffix;
}


-(NSString*)sectorKey {
	NSString *sectorKey = (NSString*)self.backend[@"sectorKey"];
	return sectorKey;
}


-(void)setSectorKey:(NSString*)sectorKey {
	self.backend[@"sectorKey"] = sectorKey;
}


-(void)saveToFile {
	NSError *error = nil;
	[self.backend writeToURL:self.saveUrl error:&error];
}


-(BOOL)isValid {
	return self.backend != nil;
}


-(void)reload {
	self.backend = [self.resourceUtil getPListMutableDict:BACKEND_KEY];
}

@end
