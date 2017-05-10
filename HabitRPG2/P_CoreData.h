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
@property (nonatomic,strong) OnlyOneEntities *userData;
@property (nonatomic,assign) NSUInteger ConcurrencyType;
+(instancetype)newWithDBFileName: (NSString *) dbFileName;
+(instancetype)newWithDBFileName:(NSString *)dbFileName AndConcurrencyType:(NSUInteger)concurrencyType;
+(instancetype)newWithConcurrencyType:(NSUInteger)concurrencyType;
-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType;
-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                       sortBy:(NSArray *) sortAttrs;
-(NSArray<NSManagedObject *> *)getItem:(NSString *) entityName
                  predicate: (NSPredicate *) filter
                     sortBy:(NSArray<NSSortDescriptor *> *) sortAttrs;
-(NSArray<NSManagedObject *> *)getItemWithRequest:(NSFetchRequest *) fetchRequest
                             predicate: (NSPredicate *)filter
                                sortBy: (NSArray<NSSortDescriptor *> *)sortArray;
-(BOOL)save:(NSManagedObject *)entity;
-(void)softDeleteModel:(NSManagedObject *)model;
-(BOOL)deleteModelAndSave:(NSManagedObject *)model;
-(void)deleteAllRecords;
-(NSManagedObjectContext *)getContextByName:(NSString *)entityName;
-(NSManagedObjectContext *)getContext:(NSManagedObject *)managedObject;
-(void)removeInsertedNotInSet:(NSSet<NSManagedObject *> *)keepThese;
@end
