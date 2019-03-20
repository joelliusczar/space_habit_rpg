//
//  DumbDataSaver.h
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/12/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface DumbDataSaver : NSObject
@property (weak,nonatomic,nullable) NSManagedObjectContext* readContext;
@property (strong,nonatomic) NSManagedObjectContext* writeContext;
@property (strong,nonatomic) NSPersistentStoreCoordinator* coordinator;
@property (strong,nonatomic) NSManagedObjectModel* model;
@property (strong,nonatomic) NSPersistentStore* store;
@property (strong,nonatomic) NSURL* storeURL;
-(void)setReader:(NSManagedObjectContext * _Nullable)readContext;
-(NSManagedObjectContext*)getReadContext;
-(void)acceptsContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
