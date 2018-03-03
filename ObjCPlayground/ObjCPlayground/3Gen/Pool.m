//
//  Pool.m
//  ObjCPlayground
//
//  Created by Joel Pridgen on 2/26/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "Pool.h"

@implementation Pool

-(void)printVolume{
    NSLog(@"Water");
}

-(void)someClassStuff:(Pool *)ourGuy{
    if([ourGuy isMemberOfClass:self.class]){
        NSLog(@"Yes self: %@ is ourGuy:%@",self.className,ourGuy.className);
    }
    else{
        NSLog(@"No self: %@ is not ourGuy:%@",self.className,ourGuy.className);
    }
    
    if([ourGuy isKindOfClass:self.class]){
        NSLog(@" self: %@ is kind of ourGuy:%@",self.className,ourGuy.className);
    }
    else{
        NSLog(@" self: %@ is not kind of ourGuy:%@",self.className,ourGuy.className);
    }
}

@end
