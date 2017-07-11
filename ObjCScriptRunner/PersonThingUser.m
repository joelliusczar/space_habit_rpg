//
//  PersonThingUser.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/9/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "PersonThingUser.h"


@implementation PersonThingUser
+(void)encodingExperiments{
    PersonThing *p1 = [[PersonThing alloc] init];
    p1.name = @"Joel";
    p1.age = 29;
    
    PersonThing *p2 = [[PersonThing alloc] init];
    [p2 setValue:[NSNumber numberWithInteger:p1.age] forKey:@"age"];
    NSLog(@"%ld",p2.age);
    
}

+(void)mutableDictPG{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@5 forKey:@"a1"];
    NSLog(@"%@",[dict valueForKey:@"a1"]);
    [dict setValue:@7 forKey:@"a1"];
    NSLog(@"%@",dict[@"a1"]);
}
@end
