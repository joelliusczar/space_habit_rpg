//
//  NoArcExp.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/11/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "NoArcExp.h"
#import "House.h"

@implementation NoArcExp

+(void)objectToCharPtr{
    House *h = [[House alloc] init];
    char *c = (char *)h;
    
}

@end
