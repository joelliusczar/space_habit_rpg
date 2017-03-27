//
//  CoreDataStackControllerP.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataInfo+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "OnlyOneEntities.h"
#import "constants.h"
@class OnlyOneEntities;

@protocol P_CoreDataStack <NSObject>
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,assign) BOOL disableSave;
@property (nonatomic,assign) BOOL disabledSaveResult;
@property (nonatomic,assign) BOOL isTesting;
@property (nonatomic,strong) OnlyOneEntities *userData;
-(instancetype)initWithDBFileName: (NSString *) dbFileName;
-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType;
-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                       sortBy:(NSArray *) sortAttrs;
-(NSManagedObject *)getItem:(NSString *) entityName
                  predicate: (NSPredicate *) filter
                     sortBy:(NSArray<NSSortDescriptor *> *) sortAttrs;
-(NSManagedObject *)getItemWithRequest:(NSFetchRequest *) fetchRequest
                             predicate: (NSPredicate *)filter
                                sortBy: (NSArray<NSSortDescriptor *> *)sortArray;
-(BOOL)save;
-(void)softDeleteModel:(NSManagedObject *)model;
-(BOOL)deleteModelAndSave:(NSManagedObject *)model;
-(void)deleteAllRecords;
@end
