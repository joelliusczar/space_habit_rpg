//
//  P_CoreData.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataInfo+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "OnlyOneEntities.h"
#import "constants.h"
@class OnlyOneEntities;

@protocol P_CoreData <NSObject>

@property (strong,nonatomic) OnlyOneEntities *userData;
@property (strong,nonatomic) NSManagedObjectContext *writeContext;
@property (strong,nonatomic) NSManagedObjectContext *readContext;
@property (strong,nonatomic) NSManagedObjectContext *inUseContext;
+(instancetype)newWithDBFileName: (NSString *) dbFileName;
-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType;
-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType InContext:(NSManagedObjectContext *)context;
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
-(dispatch_semaphore_t)save;
-(void)saveAndWait;
-(void)softDeleteModel:(NSManagedObject *)model;
-(void)insertIntoContext:(NSManagedObject *)model;

@end
