//
//  Good+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Good+CoreDataClass.h"

@implementation Good
-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.goodName,@"goodName"
            ,[NSNumber numberWithInt:self.cost],@"cost"
            ,[NSNumber numberWithInt:self.useType],@"useType"
            ,nil];
}
@end
