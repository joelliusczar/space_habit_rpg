//
//	SHObjectIDWrapper.h
//	SHData
//
//	Created by Joel Pridgen on 5/15/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHObjectIDWrapper : NSObject
@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (strong,nonatomic) NSEntityDescription *entityType;
@property (strong,nonatomic) dispatch_queue_t idSerialQueue;
-(instancetype)initWithEntityType:(NSEntityDescription *)entityType
	withContext:(NSManagedObjectContext *)context;
-(instancetype)initWithManagedObject:(NSManagedObject*)managedObject;
@end

/*
	There are some places where I specifically want to use a seperate context
	rather than the one on SHObjectIDWrapper, and for those case
	I will use the more limited interface SHObjectIDWrapper
	but in effect, everything will be SHContextObjectIDWrapper
*/
@interface SHContextObjectIDWrapper : SHObjectIDWrapper
@property (strong,nonatomic) NSManagedObjectContext *context;
@end

NS_ASSUME_NONNULL_END
