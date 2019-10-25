//
//	WeakLeash.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
#import "House.h"

@interface WeakLeash : NSObject
@property (weak,nonatomic) House *weakHouse;
@end
