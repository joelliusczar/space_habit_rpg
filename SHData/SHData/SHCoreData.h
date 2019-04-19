//
//  CoreDataStackController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHCoreDataProtocol.h"

extern NSString * const DEFAULT_DB_NAME;

@interface SHCoreDataOptions : NSObject
@property (strong,nonatomic) NSBundle *appBundle;
@property (strong,nonatomic) NSString* dbFileName;
@property (strong,nonatomic) NSString* storeType;
@property (strong,nonatomic) NSPersistentStoreCoordinator *coordinator;
@end

@interface SHCoreData : NSObject<P_CoreData>
@property (readonly,strong,nonatomic) NSBundle *appBundle;
@property (readonly,strong,nonatomic) NSString* dbFileName;
@property (readonly,strong,nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (readonly,strong,nonatomic) NSString* storeType;
@property (readonly,nonatomic) NSURL* storeURL;
+(instancetype)newWithOptionsBlock:(void (^)(SHCoreDataOptions*))optionsBlock;
-(void)forceInitialize:(BOOL)shouldForce;
-(void)initializeCoreData;
@end
