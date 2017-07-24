//
//  ControlController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ControlController.h"

@interface ControlController ()

@end

@implementation ControlController

-(instancetype)initDefault{
    if(self = [self initWithNibName:NSStringFromClass(self.class) bundle:nil])
    {}
    return self;
}


-(void)setBackgroundColor:(UIColor *)color{
    self.view.backgroundColor = color;
}

@end
