//
//  CoreDataStackController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface CoreDataStackController : NSObject
@property (nonatomic,assign) BOOL disableSave;
@property (nonatomic,assign) BOOL disabledSaveResult;
-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType;

-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                       sortBy:(NSArray *) sortAttrs;

-(BOOL)save;
-(BOOL)deleteModel:(NSManagedObject *)model;
@end
