//
//  NSManagedObjectContext+Helper.m
//  SHData
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "NSManagedObjectContext+Helper.h"

@implementation NSManagedObjectContext (Helper)


-(NSManagedObject*)newEntity:(NSEntityDescription*)entityType{
  return [[NSManagedObject alloc] initWithEntity:entityType insertIntoManagedObjectContext:self];
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
