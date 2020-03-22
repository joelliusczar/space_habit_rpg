//
//	SHObjectIDWrapper.m
//	SHData
//
//	Created by Joel Pridgen on 5/15/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHObjectIDWrapper.h"

@interface SHObjectIDWrapper ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@end


@implementation SHObjectIDWrapper


@synthesize objectID = _objectID;
-(NSManagedObjectID*)objectID{
	__block NSManagedObjectID *value = nil;
	dispatch_sync(self.idSerialQueue, ^{
		value = self->_objectID;
	});
	return value;
}


-(void)setObjectID:(NSManagedObjectID *)objectID{
	dispatch_async(self.idSerialQueue, ^{
		self->_objectID = objectID;
	});
}


-(NSManagedObjectContext*)context{
	NSAssert(_context,@"We were not expecting context to be null");
	return _context;
}


-(instancetype)init{
	if(self = [super init]){
		_idSerialQueue = dispatch_queue_create("com.SpaceHabit.SHObjectIDWrapper",DISPATCH_QUEUE_SERIAL);
	}
	return self;
}


-(instancetype)initWithEntityType:(NSEntityDescription *)entityType
	withContext:(NSManagedObjectContext *)context
{
	if(self = [self init]){
		_entityType = entityType;
		_context = context;
	}
	return self;
}


-(instancetype)initWithManagedObject:(NSManagedObject*)managedObject{
	if(self = [self init]){
		_entityType = managedObject.entity;
		_context = managedObject.managedObjectContext;
		dispatch_async(_idSerialQueue,^{
			self->_objectID = managedObject.objectID;
		});
	}
	return self;
}

@end


@implementation SHContextObjectIDWrapper
@dynamic context;
@end
