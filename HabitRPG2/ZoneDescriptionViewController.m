//
//  ZoneDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneDescriptionViewController.h"
#import "CentralViewControllerP.h"
#import "ViewHelper.h"
#import "SingletonCluster.h"
#import "constants.h"

@interface ZoneDescriptionViewController ()
@property (nonatomic,weak) ZoneChoiceViewController *prevScreen;
@property (nonatomic,weak) UIViewController <CentralViewControllerP> *central;
@property (nonatomic,weak,readonly) UITextView *zoneDescription;
@property (nonatomic,weak,readonly) UILabel *headlineLbl;
@property (nonatomic,weak,readonly) UIButton *confirmBtn;
@property (nonatomic,strong,readonly) UISwipeGestureRecognizer *backSwipe;
@property (nonatomic,weak) Zone *model;
@end

@implementation ZoneDescriptionViewController

@synthesize prevScreen = _prevScreen;
@synthesize central = _central;

@synthesize zoneDescription = _zoneDescription;
-(UITextView *)zoneDescription{
    if(!_zoneDescription){
        _zoneDescription = [self.view viewWithTag:2];
    }
    return _zoneDescription;
}

@synthesize confirmBtn = _confirmBtn;
-(UIButton *)confirmBtn{
    if(!_confirmBtn){
        UIView *v = [self getContentSubview];
        _confirmBtn = [v viewWithTag:3];
        [_confirmBtn addTarget:self action:@selector(confirmBtn_click_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@synthesize backSwipe = _backSwipe;
-(UISwipeGestureRecognizer *)backSwipe{
    if(!_backSwipe){
        _backSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipe_rightSwipe_action:)];
        _backSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _backSwipe;
}

@synthesize headlineLbl = _headlineLbl;
-(UILabel *)headlineLbl{
    if(!_headlineLbl){
        UIView *v = [self getContentSubview];
        _headlineLbl = [v viewWithTag:4];
    }
    return _headlineLbl;
}

-(instancetype)init:(ZoneChoiceViewController *)prevScreen{
    if(self = [self initWithNibName:@"StoryDumpView" bundle:nil]){
        _prevScreen = prevScreen;
        _central = prevScreen.central;
    }
    return self;
}

-(void)setDisplayItems:(Zone *)model{
    self.model = model;
    self.zoneDescription.text = model.synopsis;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.confirmBtn setTitle:@"Pick this Zone" forState:UIControlStateNormal];
    [self.confirmBtn sizeToFit];
    [self.view addGestureRecognizer:self.backSwipe];
    self.headlineLbl.text = @"";
}

-(UIView *)getContentSubview{
    return [self.view viewWithTag:1];;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backSwipe_rightSwipe_action:(UISwipeGestureRecognizer *)sender{
    [ViewHelper popViewFromFront:self];
}

-(void)confirmBtn_click_action:(UIButton *)sender{
    [ViewHelper popViewFromFront:self.prevScreen];
    [self.central afterZonePick:self.model];
}


@end
