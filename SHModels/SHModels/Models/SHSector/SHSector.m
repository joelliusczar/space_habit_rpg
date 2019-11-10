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

@implementation SHSector


+(SHSectorInfoDictionary*)sectorInfo{
	if(nil == _sectorInfo){
		id<SHResourceUtilityProtocol> resourceUtil = [SHResourceUtility new];
		_sectorInfo = [[SHSectorInfoDictionary alloc] initWithResourceUtil:resourceUtil];
	}
	return _sectorInfo;
}


+(void)setSectorInfo:(SHSectorInfoDictionary *)sectorInfo{
	_sectorInfo = sectorInfo;
}


-(NSMutableDictionary*)mapable{
	return [NSDictionary objectToDictionary:self includeSuperclassProperties:YES];
}


-(void)copyFrom:(NSObject *)object{
	copyBetween(object, self);
}


-(id)valueForUndefinedKey:(NSString *)key{
	(void)key;
	return nil;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
	(void)value;
	(void)key;
}


static void copyBetween(NSObject* from,NSObject* to){
	shCopyInstanceVar(from, to, @"isFront");
	shCopyInstanceVar(from, to, @"lvl");
	shCopyInstanceVar(from, to, @"maxMonsters");
	shCopyInstanceVar(from, to, @"monstersKilled");
	shCopyInstanceVar(from, to, @"suffix");
	shCopyInstanceVar(from, to, @"uniqueId");
	shCopyInstanceVar(from, to, @"sectorKey");
}


-(NSString *)fullName{
	NSString* name = [SHSector.sectorInfo getSectorName:self.sectorKey];
	return self.suffix.length?[NSString stringWithFormat:@"%@ %@",name,self.suffix]:name;
}


-(NSString *)synopsis{
	return [SHSector.sectorInfo getSectorDescription:self.sectorKey];
}


-(NSString *)headline{
	return @"";
}


-(SHStoryItemObjectID *)wrappedObjectID{
	SHStoryItemObjectID *wrappedObjectID = [[SHStoryItemObjectID alloc] initWithManagedObject:self];
	return wrappedObjectID;
}


-(BOOL)shouldIgnoreProperty: (NSString *)propertyName {
	if([propertyName isEqualToString:@"wrappedObjectID"]) return YES;
	if([propertyName isEqualToString:@"mapable"]) return YES;
	return NO;
}


@end
