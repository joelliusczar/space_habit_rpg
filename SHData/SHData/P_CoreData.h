//
//  P_CoreData.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHGlobal/Constants.h>
@import UIKit;
@import CoreData;

typedef NSManagedObjectContext SHContext;

@protocol P_CoreData <NSObject>

-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType;
-(NSManagedObject*)constructEmptyEntityUnattached:(NSEntityDescription*)entityType;

-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *) fetchRequest
predicate: (NSPredicate *) filter
sortBy:(NSArray *) sortAttrs;

-(NSArray<NSManagedObject *> *)getItem:(NSString *) entityName
predicate: (NSPredicate *) filter
sortBy:(NSArray<NSSortDescriptor *> *) sortAttrs;

-(NSArray<NSManagedObject *> *)getItemWithRequest:(NSFetchRequest *) fetchRequest
predicate: (NSPredicate *)filter
sortBy: (NSArray<NSSortDescriptor *> *)sortArray;

-(dispatch_semaphore_t)saveNoWaiting;
-(void)saveAndWait;
-(void)softDeleteModel:(NSManagedObject *)model;
-(void)insertIntoContext:(NSManagedObject *)model;
-(void)refreshAllContexts;
-(id)runblockInTempContext:(id (^)(void))block;
-(void)beginUsingTemporaryContext;
/*ending should not be necessary is the instance gets deallocated*/
-(void)endUsingTemporaryContext;
@end
