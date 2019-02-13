//
//  CoreDataStackController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CoreDataStackController.h"
#import <SHCommon/SingletonCluster.h>

@import CoreData;

@interface CoreDataStackController()
@property (strong,nonatomic) SHContext *writeContext;
@property (strong,nonatomic) SHContext *readContext;
@property (strong,nonatomic) SHContext *inUseContext;
@property (strong,nonatomic) NSPointerArray *tempContextStack;
@property (strong,nonatomic) NSManagedObjectModel* objectModel;
-(SHContext *)constructContext:(NSManagedObjectContextConcurrencyType)concurrencyType;
-(SHContext *)constructContextDefault;
-(id)runblock:(id (^)(void))block inContext:(SHContext *)context;
-(NSManagedObject *)openExistingObject:(NSManagedObject *)existingObject
inContext:(SHContext *)context;

@end

NSString* const DEFAULT_DB_NAME = @"Model.sqlite";

@implementation CoreDataStackController

@synthesize inUseContext = _inUseContext;

@synthesize storeType = _storeType;
-(NSString *)storeType{
  if(nil == _storeType){
    _storeType = NSSQLiteStoreType;
  }
  return _storeType;
}


@synthesize dbFileName = _dbFileName;
-(NSString *)dbFileName{
  if(nil == _dbFileName){
    _dbFileName = DEFAULT_DB_NAME;
  }
  return _dbFileName;
}


@synthesize tempContextStack = _tempContextStack;
-(NSPointerArray*)tempContextStack{
  if(nil == _tempContextStack){
    _tempContextStack = [NSPointerArray weakObjectsPointerArray];
  }
  return _tempContextStack;
}


-(NSManagedObjectModel*)objectModel{
  if(nil == _objectModel){
    NSURL *modelURL = [self.appBundle URLForResource:@"Model" withExtension:@"momd"];
    _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(_objectModel != nil, @"Error initializing Managed Object Model");
  }
  return _objectModel;
}

@synthesize coordinator = _coordinator;
-(NSPersistentStoreCoordinator *)coordinator{
  if(nil == _coordinator){
    NSManagedObjectModel *mom = self.objectModel;
    _coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
  }
  return _coordinator;
}


@synthesize writeContext = _writeContext;
-(NSManagedObjectContext *)writeContext{
    if(nil==_writeContext){
        _writeContext = [self constructContext:NSPrivateQueueConcurrencyType];
        _writeContext.name = @"Write Context";
    }
    return _writeContext;
}

@synthesize readContext = _readContext;
-(NSManagedObjectContext *)readContext{
    if(nil==_readContext){
        _readContext = [self constructContext:NSMainQueueConcurrencyType];
        _readContext.name = @"Read Context";
    }
    return _readContext;
}

-(void)setInUseContext:(SHContext *)inUseContext{
  NSString* name = inUseContext.name?inUseContext.name:@"";
  inUseContext.name = [NSString stringWithFormat:@"%@_inUseContext",name];
  _inUseContext = inUseContext;
}

-(NSURL*)storeURL{
  NSFileManager *fileManager = [NSFileManager defaultManager];
  
  NSURL *documentsURL =
  [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
  
  NSURL *storeURL = [documentsURL URLByAppendingPathComponent:self.dbFileName];
  return storeURL;
}


CoreDataStackController* setUpSelf(){
  CoreDataStackController *instance =
    [[CoreDataStackController alloc] init];
  return instance;
}

CoreDataStackController* setUpSelfWithBundle(NSBundle *bundle){
  CoreDataStackController *instance = setUpSelf();
  //The reason why I set appBundle using the
  //member ptr syntax is because the property is readonly
  instance->_appBundle = bundle;
  return instance;
}

+(instancetype)new{
    CoreDataStackController *instance = setUpSelf();
  
    [instance initializeCoreData];
    return instance;
}


+(instancetype)newWithBundle:(NSBundle *)bundle{
  CoreDataStackController *instance = setUpSelfWithBundle(bundle);
  [instance initializeCoreData];
  return instance;
}


+(instancetype)newWithBundle:(NSBundle *)bundle dBFileName:(NSString *)dbFileName{
  CoreDataStackController *instance = setUpSelfWithBundle(bundle);
  instance->_dbFileName = dbFileName;
  [instance initializeCoreData];
  return instance;
}

+(instancetype)newWithBundle:(NSBundle *)bundle storeType:(NSString *)storeType{
  CoreDataStackController *instance = setUpSelfWithBundle(bundle);
  instance->_storeType = storeType;
  [instance initializeCoreData];
  return instance;
}


-(void)initializeCoreData{
  
  NSURL* storeURL = self.storeURL;
  NSError *error = nil;
  
  NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
    [NSNumber numberWithBool:YES],
      NSMigratePersistentStoresAutomaticallyOption,
    [NSNumber numberWithBool:YES],
      NSInferMappingModelAutomaticallyOption, nil];
  
  NSPersistentStore *store =
  [self.coordinator addPersistentStoreWithType:self.storeType configuration:nil URL:storeURL
    options:options error:&error];
  
  NSAssert(store != nil,
           @"Error initializing PSC: %@\n%@",
           [error localizedDescription],[error userInfo]);
  
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType
InContext:(NSManagedObjectContext *)context{
  
  NSManagedObject *obj = [[NSManagedObject alloc] initWithEntity:entityType
    insertIntoManagedObjectContext:context];
  
  return obj;
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType{

  NSManagedObjectContext *context = [self getPreferedWriteContext];
  
  NSManagedObject *obj = [self constructEmptyEntity:entityType
                                          InContext:context];
  return obj;
}

-(NSManagedObject*)constructEmptyEntityUnattached:(NSEntityDescription*)entityType{
  return [self constructEmptyEntity:entityType InContext:nil];
}


-(NSFetchedResultsController *)getItemFetcher:(NSFetchRequest *) fetchRequest
                                    predicate: (NSPredicate *) filter
                                    sortBy:(NSArray *) sortAttrs
{
    NSManagedObjectContext *context = self.inUseContext?self.inUseContext:self.readContext;
    
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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                    inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = entity;
    
    return [self getItemWithRequest:fetchRequest
                          predicate:filter
                             sortBy:sortAttrs];
}


-(NSArray<NSManagedObject *> *)getItemWithRequest:(NSFetchRequest *)request
predicate:(NSPredicate *)filter sortBy:(NSArray<NSSortDescriptor *> *)sortArray
{
    NSManagedObjectContext* context = self.inUseContext?self.inUseContext:self.readContext;
  
    request.predicate = filter;
    request.sortDescriptors = sortArray;
    NSError *err = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&err];
  
    context = nil;
    context.persistentStoreCoordinator = nil;
    if(!results&&err){
        handleDataError(err, @"Error fetching data");
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
  
    context.persistentStoreCoordinator = self.coordinator;
    return context;
}


-(SHContext *)constructContextDefault{
  return [self constructContext:NSMainQueueConcurrencyType];
}


-(id)runblock:(id (^)(void))block inContext:(SHContext *)context{
  [self beginUsingSpecificTemporaryContext:context];
  id result = block();
  [self endUsingTemporaryContext];
  return result;
}

-(id)runblockInTempContext:(id (^)(void))block{
  return [self runblock:block inContext:nil];
}

-(void)saveWithContext:(NSManagedObjectContext *)context{
    BOOL success;
    NSError *error;
    if(!(success = [context save:&error])){
        handleDataError(error,@"Error saving context");
    }
}


-(dispatch_semaphore_t)saveNoWaiting{
  NSManagedObjectContext *context = [self getPreferedWriteContext];
  dispatch_semaphore_t sema = dispatch_semaphore_create(0);
  /*
    I believe that since performBlock is asynchronous
    that referenced in the block on the new thread needs to be wrapped
    in an autoreleasepool block
  */
  
  [context performBlock:^{
    @autoreleasepool {
      BOOL success;
      NSError *error;
      NSLog(@"In save");
      if(!(success = [context save:&error])){
          handleDataError(error,@"Error saving context");
      }
      dispatch_semaphore_signal(sema);
    }
  }];
  
  return sema;
}


-(void)saveAndWait{
  NSManagedObjectContext *context = [self getPreferedWriteContext];
  [context performBlockAndWait:^{
    BOOL success;
    NSError *error;
    if(!(success = [context save:&error])){
        handleDataError(error,@"Error saving context");
    }
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


-(void)beginUsingTemporaryContext{
  [self beginUsingSpecificTemporaryContext:nil];
}


-(void)beginUsingSpecificTemporaryContext:(SHContext*)tempContext{
  if(self.inUseContext){
    [self.tempContextStack addPointer:(__bridge void * __nullable)(self.inUseContext)];
  }
  SHContext* tmp = tempContext?tempContext:[self constructContextDefault];
  self.inUseContext = tmp;
}


-(void)endUsingTemporaryContext{
  self.inUseContext = nil;
  SHContext* context = nil;
  for(NSUInteger idx = 0;idx < self.tempContextStack.count;idx++){
    context = (SHContext*)[self.tempContextStack pointerAtIndex:idx];
    [self.tempContextStack removePointerAtIndex:idx];
    if(context) break;
  }
  self.inUseContext = context; //context is allowed to be nill
}


static void handleDataError(NSError *error,NSString *additionalMessage){
  NSLog(@"%@: %@",additionalMessage,error.localizedFailureReason);
}

-(void)unhookStores:(SHContext *)context{
  if(nil == context) return;
  NSError* __block outerErr = nil;
  [context.persistentStoreCoordinator.persistentStores enumerateObjectsUsingBlock:
  ^(NSPersistentStore* ps,NSUInteger idx,BOOL *stop){
    (void)idx;
    NSError *err = nil;
    [context.persistentStoreCoordinator removePersistentStore:ps error:&err];
    if(err){
      *stop = YES;
      outerErr = err;
    }
  }];
  if(outerErr){
    handleDataError(outerErr, @"Something went wrong while deallocating");
  }
}


-(void)refreshAllContexts{
  [self.readContext refreshAllObjects];
  if(self.inUseContext){
    [self.inUseContext refreshAllObjects];
  }
}

//-(void)dealloc{
//  [self unhookStores:self->_readContext];
//  [self unhookStores:self->_writeContext];
//  [self unhookStores:self->_inUseContext];
//  for(NSUInteger idx = 0; idx < self.tempContextStack.count;idx++){
//    SHContext* context = (SHContext*)[self.tempContextStack pointerAtIndex:idx];
//    [self.tempContextStack removePointerAtIndex:idx];
//    [self unhookStores:context];
//  }
//
//}

@end
