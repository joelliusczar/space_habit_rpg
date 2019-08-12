//
//  SHObjectIDWrapper.m
//  SHData
//
//  Created by Joel Pridgen on 5/15/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHObjectIDWrapper.h"

@interface SHObjectIDWrapper ()
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


-(instancetype)init{
  if(self = [super init]){
    _idSerialQueue = dispatch_queue_create("com.SpaceHabit.SHObjectIDWrapper",DISPATCH_QUEUE_SERIAL);
  }
  return self;
}


-(instancetype)initWithEntityType:(NSEntityDescription *)entityType{
  if(self = [self init]){
    _entityType = entityType;
  }
  return self;
}



@end
