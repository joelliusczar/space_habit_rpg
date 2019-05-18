//
//  SHDueDateItem.h
//  SHModels
//
//  Created by Joel Pridgen on 4/5/19.
//  Copyright Â© 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHDueDateItemProtocol.h"


NS_ASSUME_NONNULL_BEGIN

@interface SHDueDateItem : NSObject<SHDueDateItemProtocol>
+(instancetype)newWithObjectID:(NSManagedObjectID*)objectId andContext:(NSManagedObjectContext*)context;
@end

NS_ASSUME_NONNULL_END
