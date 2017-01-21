//
//  ZoneDescriptionViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneDescriptionViewController.h"

@interface ZoneDescriptionViewController ()
@property (nonatomic,weak) ZoneChoiceViewController *prevScreen;
@property (nonatomic,weak) UITextView *zoneDescription;
@property (nonatomic,weak) UIButton *confirmBtn;
@property (nonatomic,strong) UISwipeGestureRecognizer *backSwipe;
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
    }
    return _confirmBtn;
}

@synthesize backSwipe = _backSwipe;
-(UISwipeGestureRecognizer *)backSwipe{
    if(!_backSwipe){
        _backSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSwipAction:)];
        _backSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    return _backSwipe;
}

-(instancetype)init:(ZoneChoiceViewController *)prevScreen WithZone:(Zone *)zone{
    if(self = [self initWithNibName:@"ZoneDescriptionViewController" bundle:nil]){
        self.prevScreen = prevScreen;
        self.zoneDescription.text = zone.synopsis;
        [self.view addGestureRecognizer:self.backSwipe];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backSwipAction:(UISwipeGestureRecognizer *)sender{
    NSLog(@"%@",@"back swipe");
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
