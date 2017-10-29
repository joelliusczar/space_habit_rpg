//
//  ExpNonNull.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "House.h"

@interface ExpNonNull : NSObject
+(int)cNonNull:(House  * _Nonnull )h;
-(int)instanceNonNulls:(House * _Nonnull)h;
+(House * _Nonnull)cRetNonNull;
-(House * _Nonnull)instanceRetNonNulls;
@end
