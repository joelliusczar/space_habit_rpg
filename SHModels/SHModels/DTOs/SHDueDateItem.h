//
//  SHDueDateItem.h
//  SHModels
//
//  Created by Joel Pridgen on 4/5/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_DueDateItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface DueDateItem : NSObject<P_DueDateItem>
+(instancetype)newWithObjectID:(NSManagedObjectID*)objectId andContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
