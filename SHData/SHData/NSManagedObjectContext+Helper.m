//
//  NSManagedObjectContext+Helper.m
//  SHData
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSManagedObjectContext+Helper.h"

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


-(NSManagedObject*)getExistingOrNewEntityWithObjectID:(nullable NSManagedObjectID*)objectID{
  NSError *error = nil;
  NSManagedObject *entity = [self existingObjectWithID:objectID error:&error];
  if(nil == entity){
    entity = [self newEntity:objectID.entity];
  }
  return entity;
}

-(NSArray<NSManagedObject *> *)getItemsWithRequest:(NSFetchRequest *) fetchRequest{
  NSArray<NSManagedObject*> *results = nil;
  NSError *error = nil;
  results = [self executeFetchRequest:fetchRequest error:&error];
  return results;
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


@end
