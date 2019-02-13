//
//  CoreDataStackController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/6/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_CoreData.h"

extern NSString * const DEFAULT_DB_NAME;

@interface CoreDataStackController : NSObject<P_CoreData>
@property (readonly,strong,nonatomic) NSBundle *appBundle;
@property (readonly,strong,nonatomic) NSString* dbFileName;
@property (strong,nonatomic) NSPersistentStoreCoordinator *coordinator;
@property (readonly,strong,nonatomic) NSString* storeType;
@property (readonly,nonatomic) NSURL* storeURL;
+(instancetype)newWithBundle:(NSBundle *)bundle dBFileName:(NSString *)dbFileName;
+(instancetype)newWithBundle:(NSBundle *)bundle;
+(instancetype)newWithBundle:(NSBundle *)bundle storeType:(NSString *)storeType;
-(void)initializeCoreData;
-(NSManagedObject *)getWritableObjectVersion:(NSManagedObject *)existingObject;
@end
