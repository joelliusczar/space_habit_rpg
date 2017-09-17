//
//  Holder.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PossibleInvocationCockblock.h"

@interface Holder : NSObject
@property (strong,nonatomic) id<PossibleInvocationCockblock> cb;
@end
