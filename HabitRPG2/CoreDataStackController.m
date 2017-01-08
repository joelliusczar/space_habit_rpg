//
//  CoreDataStackController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CoreDataStackController.h"


@import CoreData;

@interface CoreDataStackController()

@property (nonatomic,strong) NSString* dbFileName;

-(void)initializeCoreData;

@end

@implementation CoreDataStackController

-(id)init{
    return [self initWithDBFileName:@"Model.sqlite"];
}

-(id)initWithDBFileName: (NSString *) dbFileName{
    self = [super init];
    if(!self){
        return nil;
    }
    self.dbFileName = dbFileName.length?dbFileName:@"Model.sqlite";
    [self initializeCoreData];
    
    return self;
}

-(void)initializeCoreData{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managaed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setContext:moc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:self.dbFileName];
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        NSError *error = nil;
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSPersistentStoreCoordinator *psc = [[self context] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
        NSAssert(store != nil,@"Error initializing PSC: %@\n%@",[error localizedDescription],[error userInfo]);
        
    });
}

-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:entityType inManagedObjectContext:self.context];
    return obj;
}


-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                    sortBy:(NSArray *) sortAttrs
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    fetchRequest.entity = entity;
    [fetchRequest setFetchBatchSize:0];
    
    fetchRequest.sortDescriptors = sortAttrs;
    
    fetchRequest.predicate = filter;
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
    
}


-(BOOL)save{
    
    if(self.disableSave){
        return self.disabledSaveResult;
    }
    
    NSError *error;
    BOOL success;
    if(!(success = [self.context save:&error])){
        NSLog(@"Error saving context: %@",error.localizedFailureReason);
    }
    return success;
}

-(BOOL)deleteModel:(NSManagedObject *)model{
    [self.context deleteObject:model];
    return [self save];
}

-(void)deleteAllForEntity:(NSString *) entityName{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *err = nil;
    [self.context.persistentStoreCoordinator executeRequest:deleteRequest withContext:self.context error:&err];
}

-(void)deleteAllRecords{
    [self deleteAllForEntity:@"Hero"];
    [self deleteAllForEntity:@"DataInfo"];
    [self deleteAllForEntity:@"Monster"];
    [self deleteAllForEntity:@"Zone"];
    [self deleteAllForEntity:@"Settings"];
    [self deleteAllForEntity:@"Daily"];
    [self deleteAllForEntity:@"Good"];
    [self deleteAllForEntity:@"Todo"];
}






@end
