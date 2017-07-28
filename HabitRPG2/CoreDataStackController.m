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
@property (nonatomic,assign) BOOL isTesting;
@property (nonatomic,readonly) NSString* storeType;
@property (nonatomic,strong) NSMutableDictionary<NSString *,NSManagedObjectContext *> *contexts;
-(void)initializeCoreData;
@end

NSString *defaultDbName = @"Model.sqlite";

@implementation CoreDataStackController

@synthesize inUseContext = _inUseContext;


-(BOOL)isTesting{
    return [SingletonCluster getSharedInstance].EnviromentNum&ENV_UTEST;
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


@synthesize coordinator = _coordinator;
-(NSPersistentStoreCoordinator *)coordinator{
    
    if(!_coordinator){
        NSURL *modelURL =
        [[NSBundle bundleForClass:self.class]
         URLForResource:@"Model" withExtension:@"momd"];
        
        NSManagedObjectModel *mom =
        [[NSManagedObjectModel alloc]
         initWithContentsOfURL:modelURL];
        
        NSAssert(mom != nil, @"Error initializing Managaed Object Model");
        
        _coordinator =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        
    }
    return _coordinator;
}


@synthesize writeContext = _writeContext;
-(NSManagedObjectContext *)writeContext{
    if(nil==_writeContext){
        _writeContext = [self constructContext:NSPrivateQueueConcurrencyType];
    }
    return _writeContext;
}

@synthesize readContext = _readContext;
-(NSManagedObjectContext *)readContext{
    if(nil==_readContext){
        _readContext = [self constructContext:NSMainQueueConcurrencyType];
    }
    return _readContext;
}

-(instancetype)init{
    if(self=[super init]){
        _dbFileName = defaultDbName;
    }
    return self;
}

+(instancetype)new{
    CoreDataStackController *instance =
    [[CoreDataStackController alloc] init];
    
    if(instance==nil){
        return nil;
    }
    [instance initializeCoreData];
    return instance;
}

+(instancetype)newWithDBFileName: (NSString *) dbFileName{
    CoreDataStackController *instance =
    [[CoreDataStackController alloc] init];
    
    if(instance==nil){
        return nil;
    }
    instance.dbFileName = dbFileName.length?dbFileName:defaultDbName;
    [instance initializeCoreData];
    return instance;
}


-(void)initializeCoreData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *documentsURL =
    [[fileManager URLsForDirectory:NSDocumentDirectory
                         inDomains:NSUserDomainMask] lastObject];
    
    NSURL *storeURL =
    [documentsURL URLByAppendingPathComponent:self.dbFileName];
    
    NSError *error = nil;
    
    NSDictionary *options =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [NSNumber numberWithBool:YES],
     NSMigratePersistentStoresAutomaticallyOption,
     [NSNumber numberWithBool:YES],
     NSInferMappingModelAutomaticallyOption, nil];
    
    NSPersistentStore *store =
    [self.coordinator addPersistentStoreWithType:self.storeType
                                   configuration:nil
                                             URL:storeURL
                                         options:options error:&error];
    
    NSAssert(store != nil,
             @"Error initializing PSC: %@\n%@",
             [error localizedDescription],[error userInfo]);
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType
                               InContext:(NSManagedObjectContext *)context{
    
    NSManagedObject *obj = [[NSManagedObject alloc]
                            initWithEntity:entityType
                            insertIntoManagedObjectContext:context];
    
    return obj;
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    
    NSManagedObject *obj = [self constructEmptyEntity:entityType
                                            InContext:context];
    return obj;
}


-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *) fetchRequest
                                    predicate: (NSPredicate *) filter
                                    sortBy:(NSArray *) sortAttrs
{
    NSManagedObjectContext *context =
    self.inUseContext?self.inUseContext:self.readContext;
    
    [fetchRequest setFetchBatchSize:0];
    fetchRequest.sortDescriptors = sortAttrs;
    fetchRequest.predicate = filter;
    
    return [[NSFetchedResultsController alloc]
            initWithFetchRequest:fetchRequest
            managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
}


-(NSArray<NSManagedObject *> *)getItem:(NSString *) entityName
                        predicate: (NSPredicate *) filter
                        sortBy:(NSArray *) sortAttrs
{
    
    NSManagedObjectContext *context =
    self.inUseContext?self.inUseContext:self.readContext;
    
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:entityName
                inManagedObjectContext:context];
    
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
    NSManagedObjectContext *context =
    self.inUseContext?self.inUseContext:self.readContext;
    
    request.predicate = filter;
    request.sortDescriptors = sortArray;
    NSError *err;
    
    NSArray *results = [context executeFetchRequest:request error:&err];
    if(!results&&err){
        NSLog(@"Error fetching data: %@", err.localizedFailureReason);
        return nil;
    }
    if(results.count < 1){
        return nil;
    }
    return results;
}


-(NSManagedObjectContext *)constructContext:
(NSManagedObjectContextConcurrencyType)concurrencyType{
    
    NSManagedObjectContext *context =
    [[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
    
    [context setPersistentStoreCoordinator:self.coordinator];
    return context;
}


-(void)saveWithContext:(NSManagedObjectContext *)context{
    BOOL success;
    NSError *error;
    if(!(success = [context save:&error])){
        NSLog(@"Error saving context: %@",error.localizedFailureReason);
    }
}


-(dispatch_semaphore_t)save{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    [context performBlock:^{
        [self saveWithContext:context];
        dispatch_semaphore_signal(sema);
    }];
    return sema;
}


-(void)saveAndWait{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    [context performBlockAndWait:^{
        [self saveWithContext:context];
    }];
}


-(void)softDeleteModel:(NSManagedObject *)model{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    [context deleteObject:model];
}


-(void)insertIntoContext:(NSManagedObject *)model{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    [context insertObject:model];
}


-(NSManagedObject *)openExistingObject:(NSManagedObject *)existingObject
                             inContext:(NSManagedObjectContext *)context{
    return [context objectWithID:existingObject.objectID];
}


-(NSManagedObject *)getWritableObjectVersion:(NSManagedObject *)existingObject{
    NSManagedObjectContext *context = [self getPreferedWriteContext];
    return [self openExistingObject:existingObject inContext:context];
}

-(NSManagedObjectContext *)getPreferedWriteContext{
    return self.inUseContext?self.inUseContext:self.writeContext;
}

@end
