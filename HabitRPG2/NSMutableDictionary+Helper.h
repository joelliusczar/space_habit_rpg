//
//  NSMutableDictionary+Helper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Helper)
-(NSMutableSet *)getOrCreateMutableSetAtKeyedSubscript:(id)key;
@end