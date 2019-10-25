//
//  DumbDataSaver.h
//  TestCommon
//
//  Created by Joel Pridgen on 3/10/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import CoreData;



NS_ASSUME_NONNULL_BEGIN

@interface DumbDataSaver : NSObject
@property (weak,nonatomic,nullable) NSManagedObjectContext* readContext;
@property (strong,nonatomic) NSManagedObjectContext* writeContext;
@property (strong,nonatomic) NSPersistentStoreCoordinator* coordinator;
@property (strong,nonatomic) NSManagedObjectModel* model;
@property (strong,nonatomic) NSPersistentStore* store;
@property (strong,nonatomic) NSURL* storeURL;
@end

NS_ASSUME_NONNULL_END
