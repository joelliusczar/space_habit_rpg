//
//  SHObjectIDWrapper.h
//  SHData
//
//  Created by Joel Pridgen on 5/15/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHObjectIDWrapper : NSObject
@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (strong,nonatomic) NSEntityDescription *entityType;
@property (strong,nonatomic) dispatch_queue_t idSerialQueue;
-(instancetype)initWithEntityType:(NSEntityDescription *)entityType;
@end

NS_ASSUME_NONNULL_END
