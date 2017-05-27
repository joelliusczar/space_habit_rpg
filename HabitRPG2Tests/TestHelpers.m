//
//  TestHelpers.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TestHelpers.h"

@implementation TestHelpers

+(void)resetCoreData:(NSManagedObjectContext *)context{
    NSPersistentStore *ps = context.persistentStoreCoordinator.persistentStores[0];
    NSError *err;
    [context.persistentStoreCoordinator removePersistentStore:ps error:&err];
}

@end
