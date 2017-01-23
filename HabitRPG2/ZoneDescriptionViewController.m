//
//  ZoneDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneDescriptionViewController.h"
#import "ViewHelper.h"

@interface ZoneDescriptionViewController ()
@property (nonatomic,weak) ZoneChoiceViewController *prevScreen;
@property (nonatomic,weak) UITextView *zoneDescription;
@property (nonatomic,weak) UIButton *confirmBtn;
@property (nonatomic,strong) UISwipeGestureRecognizer *backSwipe;
@property (nonatomic,weak) Zone *model;
@end

@implementation ZoneDescriptionViewController

@synthesize zoneDescription = _zoneDescription;
-(UITextView *)zoneDescription{
    if(!_zoneDescription){
        _zoneDescription = [self.view viewWithTag:1];
    }
    return _zoneDescription;
}

@synthesize confirmBtn = _confirmBtn;
-(UIButton *)confirmBtn{
    if(!_confirmBtn){
        _confirmBtn = [self.view viewWithTag:2];
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

-(instancetype)init:(ZoneChoiceViewController *)prevScreen{
    if(self = [self initWithNibName:@"ZoneDescriptionViewController" bundle:nil]){
        self.prevScreen = prevScreen;
        [self.view addGestureRecognizer:self.backSwipe];
    }
    return self;
}

-(void)setDisplayItems:(Zone *)model{
    self.model = model;
    self.zoneDescription.text = model.synopsis;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self confirmBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backSwipe_rightSwipe_action:(UISwipeGestureRecognizer *)sender{
    [ViewHelper popViewFromFront:self OfParent:self.prevScreen];
}

-(void)confirmBtn_click_action:(UIButton *)sender{
    [self.prevScreen saveZoneChoice:self.model];
    [self.prevScreen jumpToCentralView:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
