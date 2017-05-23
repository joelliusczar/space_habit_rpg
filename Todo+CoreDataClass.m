//
//  Todo+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Todo+CoreDataClass.h"

@implementation Todo
-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.todoName,@"todoName"
            ,self.dueDate,@"dueDate"
            ,self.effectiveDate,@"effectiveDate"
            , nil];
}
@end
