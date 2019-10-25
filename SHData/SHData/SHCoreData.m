//
//	CoreDataStackController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/6/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHCoreData.h"
@import SHCommon;

@import CoreData;

@implementation SHCoreDataOptions

-(NSString *)storeType{
	if(nil == _storeType){
		_storeType = NSSQLiteStoreType;
	}
	return _storeType;
}


-(NSString *)dbFileName{
	if(nil == _dbFileName){
		_dbFileName = DEFAULT_DB_NAME;
	}
	return _dbFileName;
}

@synthesize appBundle = _appBundle;
-(NSBundle*)appBundle{
	if(nil == _appBundle){
		_appBundle = [NSBundle mainBundle];
	}
	return _appBundle;
}

-(void)setAppBundle:(NSBundle *)appBundle{
	NSAssert(appBundle,@"appBundle cannot be null");
	_appBundle = appBundle;
}

@end

@interface SHCoreData()
@property (strong,nonatomic) SHCoreDataOptions *options;
@property (strong,nonatomic) NSManagedObjectModel* objectModel;
@end

NSString* const DEFAULT_DB_NAME = @"Model.sqlite";

@implementation SHCoreData


-(SHCoreDataOptions*)options{
	if(nil == _options){
		_options = [SHCoreDataOptions new];
	}
	return _options;
}


-(NSString *)storeType{
	return self.options.storeType;
}


-(NSString *)dbFileName{
	return self.options.dbFileName;
}


-(NSBundle*)appBundle{
	return self.options.appBundle;
}

-(NSManagedObjectModel*)objectModel{
	if(nil == _objectModel){
		if(self.options.coordinator){
			_objectModel = self.options.coordinator.managedObjectModel;
		}
		else{
			NSURL *modelURL = [self.appBundle URLForResource:@"Model" withExtension:@"momd"];
			_objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
			NSAssert(_objectModel != nil, @"Error initializing Managed Object Model");
		}
	}
	return _objectModel;
}


-(NSPersistentStoreCoordinator *)coordinator{
	if(nil == self.options.coordinator){
		NSManagedObjectModel *mom = self.objectModel;
		self.options.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
	}
	return self.options.coordinator;
}


@synthesize mainThreadContext = _mainThreadContext;
-(NSManagedObjectContext *)mainThreadContext{
		if(nil==_mainThreadContext){
			_mainThreadContext = [self newContext:NSMainQueueConcurrencyType];
			_mainThreadContext.name = @"Read Context";
		}
		return _mainThreadContext;
}


-(NSURL*)storeURL{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSURL *documentsURL =
	[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	
	NSURL *storeURL = [documentsURL URLByAppendingPathComponent:self.dbFileName];
	return storeURL;
}

+(instancetype)newWithOptionsBlock:(void (^)(SHCoreDataOptions *))optionsBlock{
	
	SHCoreData *instance = [SHCoreData new];
	SHCoreDataOptions *options = instance.options;
	if(optionsBlock){
		optionsBlock(options);
	}
	[instance initializeCoreData];
	return instance;
}

-(void)forceInitialize:(BOOL)shouldForce{
	if(self.options.coordinator && !shouldForce) return;
	NSURL* storeURL = self.storeURL;
	NSError *error = nil;
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithBool:YES],
			NSMigratePersistentStoresAutomaticallyOption,
		[NSNumber numberWithBool:YES],
			NSInferMappingModelAutomaticallyOption, nil];
	NSPersistentStore *store = nil;
	//addPersistentStore was putting store in a autoreleasepool
	//where it was sticking around forever. This wouldn't necessarily be a problem
	//but it may be fucking up my unit tests
	//so we use the @autoreleasepool block to get it out of the system.
	@autoreleasepool {
			store = [self.coordinator addPersistentStoreWithType:self.storeType configuration:nil URL:storeURL
				options:options error:&error];
			if(store == nil){
				handleDataError(error, [NSString stringWithFormat:@"Error initializing PSC: %@\n%@",
					error.localizedDescription,error.userInfo]);
			}
		
	}
}

-(void)initializeCoreData{
	[self forceInitialize:NO];
}


-(NSManagedObjectContext *)newContext:(NSManagedObjectContextConcurrencyType)concurrencyType {
	
		NSManagedObjectContext *context =
			[[NSManagedObjectContext alloc] initWithConcurrencyType:concurrencyType];
	
		context.persistentStoreCoordinator = self.coordinator;
		return context;
}


static void handleDataError(NSError *error,NSString *additionalMessage){
	NSLog(@"%@: %@",additionalMessage,error.localizedFailureReason);
}



- (NSManagedObjectContext *)newBackgroundContext {
	return [self newContext:NSPrivateQueueConcurrencyType];
}

@end
