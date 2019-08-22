//
//	SHSector+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector.h"
#import <SHCommon/SHCommonUtils.h>

@implementation SHSector


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

@end
