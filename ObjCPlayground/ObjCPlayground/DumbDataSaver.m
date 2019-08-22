//
//	DumbDataSaver.m
//	ObjCPlayground
//
//	Created by Joel Pridgen on 3/12/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "DumbDataSaver.h"


@implementation DumbDataSaver
{
	NSManagedObjectContext* _reader;
}

-(void)setReader:(NSManagedObjectContext *)readContext{
	_reader = readContext;
}

-(NSManagedObjectContext*)getReadContext{
	return _reader;
}


-(void)setReadContext:(NSManagedObjectContext *)readContext{
	_readContext = readContext;
}

+(instancetype)new{
	DumbDataSaver* instance = [[DumbDataSaver alloc] init];
	
	NSBundle* dumbBundle = [NSBundle bundleForClass:NSClassFromString(@"OnlyOneEntities")];
	NSURL *modelURL = [dumbBundle URLForResource:@"Model" withExtension:@"momd"];
	instance.model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	instance.coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:instance.model];
	NSURL *documentsURL =	[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	
	instance.storeURL = [documentsURL URLByAppendingPathComponent:@"Model.sqlite"];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
		[NSNumber numberWithBool:YES],
			NSMigratePersistentStoresAutomaticallyOption,
		[NSNumber numberWithBool:YES],
			NSInferMappingModelAutomaticallyOption, nil];
		NSError *error = nil;
	instance.store = [instance.coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:instance.storeURL
			options:options error:&error];
	
	return instance;
}


-(void)acceptsContext:(NSManagedObjectContext *)context{
	NSLog(@"%@",context);
}

@end
