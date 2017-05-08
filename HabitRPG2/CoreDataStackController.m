//
//  CoreDataStackController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CoreDataStackController.h"
#import "SingletonCluster.h"

@import CoreData;

@interface CoreDataStackController()

@property (nonatomic,strong) NSString* dbFileName;
@property (nonatomic,strong) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic,readonly) BOOL disableSave;
@property (nonatomic,assign) BOOL disabledSaveResult;
@property (nonatomic,assign) BOOL isTesting;
@property (nonatomic,readonly) NSString* storeType;
@property (nonatomic,strong) NSMutableDictionary<NSString *,NSManagedObjectContext *> *contexts;
-(void)initializeCoreData;

@end

@implementation CoreDataStackController

-(BOOL)isTesting{
    return [SingletonCluster getSharedInstance].EnviromentNum != ENV_DEFAULT;
}

-(NSString *)storeType{
    return self.isTesting?NSInMemoryStoreType:NSSQLiteStoreType;
}
    

@synthesize userData = _userData;
-(OnlyOneEntities *)userData{
    if(!_userData){
        _userData = [[OnlyOneEntities alloc] initWithDataController:self];
    }
    return _userData;
}

@synthesize contexts = _contexts;
-(NSMutableDictionary<NSString *,NSManagedObjectContext *> *)contexts{
    if(!_contexts){
        _contexts = [NSMutableDictionary dictionary];
    }
    return _contexts;
}

@synthesize coordinator = _coordinator;
-(NSPersistentStoreCoordinator *)coordinator{
    if(!_coordinator){
        NSURL *modelURL = [[NSBundle bundleForClass:self.class] URLForResource:@"Model" withExtension:@"momd"];
        NSManagedObjectModel *mom =
        [[NSManagedObjectModel alloc]
         initWithContentsOfURL:modelURL];
        NSAssert(mom != nil, @"Error initializing Managaed Object Model");
        
        _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    }
    return _coordinator;
}

-(instancetype)initWithDBFileName: (NSString *) dbFileName{
    self = [super init];
    if(!self){
        return nil;
    }
    self.dbFileName = dbFileName.length?dbFileName:@"Model.sqlite";
    [self initializeCoreData];
    
    return self;
}

-(NSManagedObjectContext *)getContext:(NSManagedObject *)managedObject{
    return [self getContextByName:managedObject.entity.name];
}

-(NSManagedObjectContext *)getContextByName:(NSString *)entityName{
    if(self.coordinator.managedObjectModel.entitiesByName[entityName]){
        NSManagedObjectContext *c = nil;
        if(!(c=self.contexts[entityName])){
            c = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [c setPersistentStoreCoordinator:self.coordinator];
            self.contexts[entityName] = c;
        }
        return c;
    }
    return nil;
}

-(void)initializeCoreData{
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:self.dbFileName];
    
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    NSPersistentStore *store = [self.coordinator addPersistentStoreWithType:self.storeType configuration:nil URL:storeURL options:options error:&error];
    NSAssert(store != nil,@"Error initializing PSC: %@\n%@",[error localizedDescription],[error userInfo]);
}

-(NSManagedObject *)constructEmptyEntity:(NSString *) entityType{
    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:entityType inManagedObjectContext:[self getContextByName:entityType]];
    return obj;
}


-(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                    predicate: (NSPredicate *) filter
                                    sortBy:(NSArray *) sortAttrs
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getContextByName:entityName]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    [fetchRequest setFetchBatchSize:0];
    fetchRequest.sortDescriptors = sortAttrs;
    fetchRequest.predicate = filter;
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self getContextByName:entityName] sectionNameKeyPath:nil cacheName:nil];
    
}

-(NSArray<NSManagedObject *> *)getItem:(NSString *) entityName
                        predicate: (NSPredicate *) filter
                        sortBy:(NSArray *) sortAttrs
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getContextByName:entityName]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    return [self getItemWithRequest:fetchRequest
                          predicate:filter
                             sortBy:sortAttrs];
}

-(NSArray<NSManagedObject *> *)getItemWithRequest:(NSFetchRequest *)request
                                predicate:(NSPredicate *)filter
                                sortBy:(NSArray<NSSortDescriptor *> *)sortArray
{
    request.predicate = filter;
    request.sortDescriptors = sortArray;
    NSError *err;
    
    NSArray *results = [[self getContextByName:request.entityName] executeFetchRequest:request error:&err];
    if(!results&&err){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return nil;
    }
    if(results.count < 1){
        return nil;
    }
    return results;
}

-(BOOL)save:(NSManagedObject *)entity{
    if(self.disableSave){
        return self.disabledSaveResult;
    }
    
    NSError *error;
    BOOL success;
    if(!(success = [[self getContext:entity] save:&error])){
        NSLog(@"Error saving context: %@",error.localizedFailureReason);
    }
    return success;
}

-(void)softDeleteModel:(NSManagedObject *)model{
    [[self getContext:model] deleteObject:model];
}

-(BOOL)deleteModelAndSave:(NSManagedObject *)model{
    [self softDeleteModel:model];
    return [self save: model];
}

-(void)deleteAllForEntity:(NSString *) entityName{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
    
    NSError *err = nil;
    [[self getContextByName:entityName].persistentStoreCoordinator executeRequest:deleteRequest withContext:[self getContextByName:entityName] error:&err];
}

-(void)deleteAllRecords{
    //this should only be called in testing situations.
    NSArray<NSPersistentStore *> *stores = self.coordinator.persistentStores;
    NSPersistentStore *ps = stores[0];
    if([ps.type isEqualToString:@"InMemory"]){
        //delete all unsaved items
        for(NSEntityDescription *entityDesc in self.coordinator.managedObjectModel.entities){
            NSManagedObjectContext *c = [self getContextByName:entityDesc.name];
            [c reset];
        }
        //delete all saved items
        NSError *err = nil;
        [self.coordinator removePersistentStore:ps error:&err];
        NSAssert(!err, @"something went wrong with removing the persistent store");
        [self initializeCoreData];
    }
    else{
        for(NSEntityDescription *entityDesc in self.coordinator.managedObjectModel.entities){
            [self deleteAllForEntity:entityDesc.name];
        }
    }
}

-(void)removeInsertedNotInSet:(NSSet<NSManagedObject *> *)keepThese{
    NSString *typeName = keepThese.anyObject.entity.name;
    NSSet<NSManagedObject *> *insertedSet = [self getContextByName:typeName].insertedObjects;
    for(NSManagedObject *item in insertedSet){
        if(![keepThese containsObject:item]){
            [self softDeleteModel:item];
        }
    }
}

@end
