//
//	DumbDataSaver.m
//	TestCommon
//
//	Created by Joel Pridgen on 3/10/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "DumbDataSaver.h"

@implementation DumbDataSaver

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
	instance.store = [instance.coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:instance.storeURL
			options:options error:&error];
	
	return instance;
}

@end
