//
//	PersonThing.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/9/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;

@interface PersonThing : NSObject<NSCoding>
@property (strong,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger age;
@end
