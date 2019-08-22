//
//	GenericThing.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 11/12/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericThing<T> : NSObject
@property (strong,nonatomic) T thing;
@end

@interface GenericThings<R,T> : GenericThing<R>
@property (strong,nonatomic) T thing2;
@end
