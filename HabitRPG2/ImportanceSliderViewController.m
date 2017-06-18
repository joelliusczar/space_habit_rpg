//
//  ImportanceSliderViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ImportanceSliderViewController.h"

@interface ImportanceSliderViewController ()

@end

@implementation ImportanceSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)urgencySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate urgencyLvlChanged:sender passedEvent:event];
    }
}

- (IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate difficultyLvlChanged:sender passedEvent:event];
    }
}

@end
