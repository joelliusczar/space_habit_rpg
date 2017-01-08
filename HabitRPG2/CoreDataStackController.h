//
//  CoreDataStackController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataInfo+CoreDataClass.h"
#import "Settings+CoreDataClass.h"
#import "OnlyOneEntities.h"
@import CoreData;

@interface CoreDataStackController : NSObject
@property (nonatomic,strong) NSManagedObjectContext *context;
@property (nonatomic,assign) BOOL disableSave;
@property (nonatomic,assign) BOOL disabledSaveResult;
@property (nonatomic,strong) OnlyOneEntities *userData;
-(instancetype)initWithDBFileName: (NSString *) dbFileName;
-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType;
-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                       sortBy:(NSArray *) sortAttrs;
-(NSManagedObject *)getItem:(NSString *) entityName
                  predicate: (NSPredicate *) filter
                     sortBy:(NSArray *) sortAttrs;
-(BOOL)save;
-(BOOL)deleteModel:(NSManagedObject *)model;
-(void)deleteAllRecords;

@end
