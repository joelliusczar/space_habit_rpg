//
//  Daily+Mapable.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"

@interface Daily (Mapable)
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(void)copyInto:(NSObject *)object;
@end
