//
//  NSManagedObjectContext+Helper.h
//  SHData
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SHObjectIDWrapper.h"

#define shBasicSortDescArray(key) @[[[NSSortDescriptor alloc] initWithKey:key ascending:NO]]

NS_ASSUME_NONNULL_BEGIN

@interface NSManagedObjectContext (Helper)
-(NSManagedObject*)newEntity:(NSEntityDescription*)entityType;

-(NSManagedObject*)getExistingOrNewEntityWithObjectID:(SHObjectIDWrapper*)wrappedID;
-(NSArray<NSManagedObject *> *)getItemsWithRequest:(NSFetchRequest *) fetchRequest;
-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *)fetchRequest;
+(NSManagedObject*)newEntityUnattached:(NSEntityDescription*)entityType;
-(instancetype)createChildContext;
@end

NS_ASSUME_NONNULL_END
