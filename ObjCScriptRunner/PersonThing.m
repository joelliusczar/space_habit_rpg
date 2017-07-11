//
//  PersonThing.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/9/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "PersonThing.h"

@implementation PersonThing

-(instancetype)initWithCoder:(NSCoder *)decoder{
    if(self = [super init]){
        _name = [decoder decodeObjectForKey:@"name"];
        _age = [decoder decodeIntegerForKey:@"age"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInteger:self.age forKey:@"age"];
}

@end
