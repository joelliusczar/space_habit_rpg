//
//  VarWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VarWrapper<T> : NSObject
@property (strong,nonatomic) T item;
-(instancetype)init:(id)item, ... NS_REQUIRES_NIL_TERMINATION;
@end

@interface PairWrapper<T1,T2> : VarWrapper<T1>
@property (strong,nonatomic) T2 item2;
@end
