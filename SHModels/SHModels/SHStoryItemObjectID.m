//
//  SHStoryItemObjectID.m
//  SHModels
//
//  Created by Joel Pridgen on 9/16/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryItemObjectID.h"
#import "SHSector.h"
#import "SHMonster.h"
#import <SHCommon/NSException+SHCommonExceptions.h>


@implementation SHStoryItemObjectID


-(void)setEntityType:(NSEntityDescription *)entityType{
	if(entityType != SHSector.entity && entityType != SHMonster.entity) {
		@throw [NSException oddException];
	}
	super.entityType = entityType;
}


-(instancetype)initWithEntityType:(NSEntityDescription *)entityType withContext:(NSManagedObjectContext *)context{
	if(entityType != SHSector.entity && entityType != SHMonster.entity) {
		@throw [NSException oddException];
	}
	if(self = [super initWithEntityType:entityType withContext:context]){}
	return self;
}


-(instancetype)initWithManagedObject:(NSManagedObject *)managedObject{
	if(managedObject.entity != SHSector.entity && managedObject.entity != SHMonster.entity) {
		@throw [NSException oddException];
	}
	if(self = [super initWithManagedObject:managedObject]){}
	return self;
}




@end
