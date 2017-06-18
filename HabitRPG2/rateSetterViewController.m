//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "rateSetterViewController.h"

@interface rateSetterViewController ()

@end

@implementation rateSetterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate rateValueChanged:sender passedEvent:event];
    }
}


@end
