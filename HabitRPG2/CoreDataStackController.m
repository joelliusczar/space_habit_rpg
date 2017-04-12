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

//    @synthesize context = _context;
//    -(NSManagedObjectContext *)context{
//        if(!_context){
//            _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//            [_context setPersistentStoreCoordinator:self.coordinator];
//        }
//        return _context;
//    }

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
    
    -(NSManagedObjectContext *)getContext:(NSString *)entityName{
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
        NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:entityType inManagedObjectContext:[self getContext:entityType]];
        return obj;
    }


    -(NSFetchedResultsController *)getItemFetcher:(NSString *) entityName
                                        predicate: (NSPredicate *) filter
                                        sortBy:(NSArray *) sortAttrs
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getContext:entityName]];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = entity;
        [fetchRequest setFetchBatchSize:0];
        fetchRequest.sortDescriptors = sortAttrs;
        fetchRequest.predicate = filter;
        return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[self getContext:entityName] sectionNameKeyPath:nil cacheName:nil];
        
    }

    -(NSManagedObject *)getItem:(NSString *) entityName
                            predicate: (NSPredicate *) filter
                            sortBy:(NSArray *) sortAttrs
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self getContext:entityName]];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        fetchRequest.entity = entity;
        return [self getItemWithRequest:fetchRequest
                              predicate:filter
                                 sortBy:sortAttrs];
    }

    -(NSManagedObject *)getItemWithRequest:(NSFetchRequest *)request
                                    predicate:(NSPredicate *)filter
                                    sortBy:(NSArray<NSSortDescriptor *> *)sortArray
    {
        request.fetchLimit = 1;
        request.predicate = filter;
        request.sortDescriptors = sortArray;
        NSError *err;
        
        NSArray *results = [[self getContext:request.entityName] executeFetchRequest:request error:&err];
        if(!results&&err){
            NSLog(@"Error fetching data: %@", err.localizedFailureReason);
            return nil;
        }
        if(results.count < 1){
            return nil;
        }
        return results[0];
    }

    -(BOOL)save:(NSManagedObject *)entity{
        
        if(self.disableSave){
            return self.disabledSaveResult;
        }
        
        NSError *error;
        BOOL success;
        if(!(success = [[self getContext:entity.entity.name] save:&error])){
            NSLog(@"Error saving context: %@",error.localizedFailureReason);
        }
        return success;
    }

    -(void)softDeleteModel:(NSManagedObject *)model{
        [[self getContext:model.entity.name] deleteObject:model];
    }

    -(BOOL)deleteModelAndSave:(NSManagedObject *)model{
        [self softDeleteModel:model];
        return [self save: model];
    }

    -(void)deleteAllForEntity:(NSString *) entityName{
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
        NSBatchDeleteRequest *deleteRequest = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
        
        NSError *err = nil;
        [[self getContext:entityName].persistentStoreCoordinator executeRequest:deleteRequest withContext:[self getContext:entityName] error:&err];
    }

    -(void)deleteAllRecords{
        //this should only be called in testing situations.
        [self deleteAllForEntity:HERO_ENTITY_NAME];
        [self deleteAllForEntity:DATA_INFO_ENTITY_NAME];
        [self deleteAllForEntity:MONSTER_ENTITY_NAME];
        [self deleteAllForEntity:ZONE_ENTITY_NAME];
        [self deleteAllForEntity:SETTINGS_ENTITY_NAME];
        [self deleteAllForEntity:DAILY_ENTITY_NAME];
        [self deleteAllForEntity:HABIT_ENTITY_NAME];
        [self deleteAllForEntity:TODO_ENTITY_NAME];
        [self deleteAllForEntity:GOOD_ENTITY_NAME];
    }

@end
