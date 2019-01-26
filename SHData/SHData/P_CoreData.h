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

@protocol P_CoreData <NSObject>

@property (strong,nonatomic) NSManagedObjectContext *writeContext;
@property (strong,nonatomic) NSManagedObjectContext *readContext;
@property (strong,nonatomic) NSManagedObjectContext *inUseContext;
+(instancetype)newWithBundle:(NSBundle *)bundle dBFileName:(NSString *)dbFileName;
-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType;
-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType
  InContext:(NSManagedObjectContext *)context;
-(void)initializeCoreData;
-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *) fetchRequest
  predicate: (NSPredicate *) filter
  sortBy:(NSArray *) sortAttrs;
-(NSArray<NSManagedObject *> *)getItem:(NSString *) entityName
  predicate: (NSPredicate *) filter
  sortBy:(NSArray<NSSortDescriptor *> *) sortAttrs;
-(NSArray<NSManagedObject *> *)getItemWithRequest:(NSFetchRequest *) fetchRequest
  predicate: (NSPredicate *)filter
  sortBy: (NSArray<NSSortDescriptor *> *)sortArray;
-(NSManagedObjectContext *)constructContext:(NSManagedObjectContextConcurrencyType)concurrencyType;
-(dispatch_semaphore_t)saveNoWaiting;
-(void)saveAndWait;
-(void)softDeleteModel:(NSManagedObject *)model;
-(void)insertIntoContext:(NSManagedObject *)model;
-(NSManagedObject *)openExistingObject:(NSManagedObject *)existingObject inContext:(NSManagedObjectContext *)context;
-(NSManagedObject *)getWritableObjectVersion:(NSManagedObject *)existingObject;
@end
