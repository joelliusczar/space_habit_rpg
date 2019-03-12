//
//  DumbCoreDataController.h
//  TestCommon
//
//  Created by Joel Pridgen on 3/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHData/P_CoreData.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const DEFAULT_DB_NAME;

@interface DumbCoreDataController : NSObject<P_CoreData>
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

NS_ASSUME_NONNULL_END




