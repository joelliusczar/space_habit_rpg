//
//  ZoneDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSectorDescriptionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHSingletonCluster.h>
#import <SHGlobal/SHConstants.h>
#import <SHControls/SHButton.h>

@interface SHSectorDescriptionViewController ()
@property (weak,nonatomic) SHSectorChoiceViewController *prevScreen;
@property (weak,nonatomic) SHCentralViewController *central;
@property (readonly,strong,nonatomic) UISwipeGestureRecognizer *backSwipe;
@end

@implementation SHSectorDescriptionViewController


@synthesize backSwipe = _backSwipe;
-(UISwipeGestureRecognizer *)backSwipe{
    if(!_backSwipe){
        _backSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipe_rightSwipe_action:)];
        _backSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _backSwipe;
}


-(instancetype)init:(SHSectorChoiceViewController *)prevScreen{
    if(self = [self initWithNibName:@"SHStoryDumpView" bundle:nil]){
        _prevScreen = prevScreen;
        _central = prevScreen.central;
    }
    return self;
}

-(void)setDisplayItems:(SHSectorDTO *)model{
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
    [self popVCFromFront];
}
- (IBAction)doneBtn_pressed_action:(SHButton *)sender forEvent:(UIEvent *)event{
    [self.prevScreen popVCFromFront];
    [self.central afterZonePick:(SHSectorDTO *)self.storyItem withContext:nil];
}


#pragma clang diagnostic pop

@end
