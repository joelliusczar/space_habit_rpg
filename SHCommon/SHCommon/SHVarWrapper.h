//
//  SHVarWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

#define vw(item) [[SHVarWrapper alloc] init:item,nil]
#define pw(item1,item2) [[SHPairWrapper alloc] init:item1,item2,nil]

@interface SHVarWrapper<T> : NSObject
@property (strong,nonatomic) T item;
-(instancetype)init:(id)item, ... NS_REQUIRES_NIL_TERMINATION;
@end

@interface SHPairWrapper<T1,T2> : SHVarWrapper<T1>
@property (strong,nonatomic) T2 item2;
@end
