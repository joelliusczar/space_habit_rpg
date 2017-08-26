//
//  House.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface House : NSObject
@property (strong,nonatomic) NSString *couch;
@property (assign,nonatomic) NSInteger count;
@property (assign,nonatomic) NSInteger lamps;
-(void)returnsNothing;
-(NSInteger)getFive;
@end

#import "House+Things.h"
