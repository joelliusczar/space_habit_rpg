//
//  Experiments.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <objc/runtime.h>
#import "Experiments.h"
#import "House.h"


@implementation Experiments
+(void)dateToJSON{
    NSDate *d1 = [NSDate date];
    NSError *wrong = nil;
    NSDictionary *dict = [NSDictionary dictionaryWithObject:d1 forKey:@"d1"];
    NSData *json = [NSJSONSerialization
                    dataWithJSONObject:dict
                    options:NSJSONWritingPrettyPrinted error:&wrong];
    NSString *jsonStr = [[NSString alloc]
                         initWithData:json
                         encoding:NSUTF8StringEncoding];
    NSLog(@"%@",jsonStr);
}

+(void)getAllIvar{
    House *h = [[House alloc] init];
    h.count = 8;
    h.lamps = 19;
    h.couch = @"Green";

    unsigned int count;
    Ivar* ivars = class_copyIvarList(House.class,&count);
    for(int i=0;i<count;i++){

        NSString * str = [NSString stringWithUTF8String:ivar_getName(ivars[i])];
        NSLog(@"%@",[h valueForKey:str]);

    }
    free(ivars);
}
@end
