//
//	NSManagedObjectContext+Helper.m
//	SHData
//
//	Created by Joel Pridgen on 3/25/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSManagedObjectContext+Helper.h"
#import <SHCommon/NSException+SHCommonExceptions.h>

@implementation NSManagedObjectContext (Helper)


static void _setupIfRequired(NSManagedObject *entity){
	SEL setupSelector = NSSelectorFromString(@"setupInitialState");
	if([entity respondsToSelector:setupSelector]){
		IMP imp = [entity methodForSelector:setupSelector];
		((void (*)(id,SEL))imp)(entity,setupSelector);
	}
}

-(NSManagedObject*)newEntity:(NSEntityDescription*)entityType{
	NSManagedObject *entity = [[NSManagedObject alloc]
		initWithEntity:entityType
		insertIntoManagedObjectContext:self];
	_setupIfRequired(entity);
	return entity;
}


-(NSManagedObject*)getExistingOrNewEntityWithObjectID:(SHObjectIDWrapper*)wrappedID{
	__block NSError *error = nil;
	__block NSManagedObject *entity = nil;
	//want this on a synchronized block so that we don't accidently
	//create more entities than we meant to due to race conditions
	[self performBlockAndWait:^{
		if(nil == wrappedID.objectID){
			entity = [self newEntity:wrappedID.entityType];
			wrappedID.objectID = entity.objectID;
		}
		else{
			entity = [self existingObjectWithID:wrappedID.objectID error:&error];
			if(entity.entity != wrappedID.entityType) {
				@throw [NSException oddException];
			}
		}
	}];
	return entity;
}


-(NSManagedObject*)getEntityOrNil:(SHObjectIDWrapper *)objectId withError:(NSError **)error{
	if(nil == objectId || nil == objectId.objectID) return nil;
	if(error) {
		*error = nil;
	}
	NSManagedObject *result = [self existingObjectWithID:objectId.objectID error:error];
	if(error && *error){
		NSLog(@"error %@",[*error localizedDescription]);
		return nil;
	}
	if(nil == result && error) {
		*error = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain code:1 userInfo:@{ @"Reason": @"No results"}];
	}
	if(result.entity != objectId.entityType && error) {
		*error = [[NSError alloc] initWithDomain:NSPOSIXErrorDomain code:1 userInfo:@{ @"Reason": @"Mismatched type"}];
	}
	return result;
}

-(NSArray<NSManagedObject *> *)getItemsWithRequest:(NSFetchRequest *) fetchRequest{
	NSArray<NSManagedObject*> *results = nil;
	NSError *error = nil;
	results = [self executeFetchRequest:fetchRequest error:&error];
	if(error){
		@throw [NSException dbException:error];
	}
	return results;
}


-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *)fetchRequest
	withSectionKeyPath:(NSString *)sectionKeyPath
{
	[fetchRequest setFetchBatchSize:0];
	
	return [[NSFetchedResultsController alloc]
					initWithFetchRequest:fetchRequest
					managedObjectContext:self
					sectionNameKeyPath:sectionKeyPath
					cacheName:nil];
}


-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *)fetchRequest{
	[fetchRequest setFetchBatchSize:0];
	
	return [[NSFetchedResultsController alloc]
					initWithFetchRequest:fetchRequest
					managedObjectContext:self sectionNameKeyPath:nil cacheName:nil];
}


+(NSManagedObject*)newEntityUnattached:(NSEntityDescription*)entityType{
	return [[NSManagedObject alloc] initWithEntity:entityType
			insertIntoManagedObjectContext:nil];
}


-(instancetype)createChildContext{
	NSManagedObjectContext *context = [[NSManagedObjectContext alloc]
		initWithConcurrencyType:NSPrivateQueueConcurrencyType];
	context.parentContext = self;
	return context;
}


-(NSInteger)batchDelete:(NSFetchRequest *)fetchRequest withError:(NSError **)error{
	NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
	NSBatchDeleteResult *results = [self executeRequest:deleteRequest error:error];
	return ((NSNumber*)results.result).integerValue;
}

@end
