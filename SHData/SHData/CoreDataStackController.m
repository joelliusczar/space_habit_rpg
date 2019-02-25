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
  if(store == nil){
    handleDataError(error, [NSString stringWithFormat:@"Error initializing PSC: %@\n%@",
      error.localizedDescription,error.userInfo]);
  }
  
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType
InContext:(nonnull NSManagedObjectContext *)context{
  
  NSManagedObject* __block obj;
  
  [context performBlockAndWait:^{
    @autoreleasepool {
      obj = [[NSManagedObject alloc] initWithEntity:entityType
      insertIntoManagedObjectContext:context];
    }
  }];
  
  return obj;
}


-(NSManagedObject *)constructEmptyEntity:(NSEntityDescription *) entityType{

  NSManagedObjectContext *context = [self getPreferedWriteContext];
  
  NSManagedObject *obj = [self constructEmptyEntity:entityType
                                          InContext:context];
  return obj;
}

-(NSManagedObject*)constructEmptyEntityUnattached:(NSEntityDescription*)entityType{
  return [[NSManagedObject alloc] initWithEntity:entityType
      insertIntoManagedObjectContext:nil];
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
  NSError* __block err = nil;
  NSArray* __block results = nil;
  [context performBlockAndWait:^{
    @autoreleasepool {
      results = [context executeFetchRequest:request error:&err];
    }
  }];
  
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


-(id)runblockInCurrentContext:(id (^)(SHContext*))block{
  SHContext* context = self.inUseContext?self.inUseContext:self.readContext;
  id __block result = nil;
  [context performBlockAndWait:^{
    @autoreleasepool {
      result = block(context);
    }
  }];
  return result;
}


-(id)runblockInTempContext:(id (^)(SHContext*))block{
  [self beginUsingTemporaryContext];
  id result = [self runblockInCurrentContext:block];
  [self endUsingTemporaryContext];
  return result;
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


-(BOOL)saveAndWait{
  NSManagedObjectContext *context = [self getPreferedWriteContext];
  BOOL __block success = FALSE;
  [context performBlockAndWait:^{
    NSError *error;
    if(!(success = [context save:&error])){
        handleDataError(error,@"Error saving context");
    }
  }];
  return success;
}


-(BOOL)softDeleteModel:(NSManagedObject *)model{
  NSManagedObjectContext *context = model.managedObjectContext;
  if(nil == context) return FALSE;
  [context performBlockAndWait:^{
    [context deleteObject:model];
  }];
  return TRUE;
}


-(BOOL)insertIntoContext:(NSManagedObject *)model{
  //if we're inserting, then the context must be null
  //otherwise it will throw an exception
  if(model.managedObjectContext) return FALSE;
  NSManagedObjectContext *context = [self getPreferedWriteContext];
  [context performBlockAndWait:^{
      [context insertObject:model];
  }];
  return TRUE;
}


-(NSManagedObject *)openExistingObject:(NSManagedObject *)existingObject
inContext:(NSManagedObjectContext *)context{
    NSManagedObject* __block altObj = nil;
    [context performBlockAndWait:^{
      altObj = [context objectWithID:existingObject.objectID];
    }];
    return altObj;
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



@end
