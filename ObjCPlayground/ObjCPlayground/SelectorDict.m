//
//  SelectorDict.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SelectorDict.h"

@implementation SelectorDict
-(id)objectForKeyedSubscript:(Class)key{
    return self.it;
}

-(void)setObject:(id)obj forKeyedSubscript:(Class)key{
    self.it = obj;
}

-(void)helloMethod{}
@end
