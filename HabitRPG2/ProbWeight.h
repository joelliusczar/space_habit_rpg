//
//  ProbWeight.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/5/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProbWeight : NSObject
    -(void)add:(NSString *)key With:(int)freq;
    -(NSString *)weightedRandomKey;
@end
