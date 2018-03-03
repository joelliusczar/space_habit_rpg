//
//  ZoneDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneDescriptionViewController.h"
#import "P_CentralViewController.h"
#import <SHCommon/ViewHelper.h>
#import <SHCommon/SingletonCluster.h>
#import <SHGlobal/Constants.h>
#import <SHControls/SHButton.h>

@interface ZoneDescriptionViewController ()
@property (weak,nonatomic) ZoneChoiceViewController *prevScreen;
@property (weak,nonatomic) UIViewController <P_CentralViewController> *central;
@property (readonly,strong,nonatomic) UISwipeGestureRecognizer *backSwipe;
@end

@implementation ZoneDescriptionViewController


@synthesize backSwipe = _backSwipe;
-(UISwipeGestureRecognizer *)backSwipe{
    if(!_backSwipe){
        _backSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipe_rightSwipe_action:)];
        _backSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _backSwipe;
}


-(instancetype)init:(ZoneChoiceViewController *)prevScreen{
    if(self = [self initWithNibName:@"StoryDumpView" bundle:nil]){
        _prevScreen = prevScreen;
        _central = prevScreen.central;
    }
    return self;
}

-(void)setDisplayItems:(Zone *)model{
    self.storyItem = model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.doneBtn setTitle:@"Pick this Zone" forState:UIControlStateNormal];
    [self.doneBtn sizeToFit];
    [self.view addGestureRecognizer:self.backSwipe];
    self.headlineLbl.text = @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wunused-parameter"

-(void)backSwipe_rightSwipe_action:(UISwipeGestureRecognizer *)sender{
    popVCFromFront(self);
}
- (IBAction)doneBtn_pressed_action:(SHButton *)sender forEvent:(UIEvent *)event  {
    popVCFromFront(self.prevScreen);
    [self.central afterZonePick:(Zone *)self.storyItem];
}


#pragma clang diagnostic pop

@end
