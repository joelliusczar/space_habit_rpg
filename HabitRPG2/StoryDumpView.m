//
//  StoryDumpView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "StoryDumpView.h"
#import "ViewHelper.h"

@interface StoryDumpView ()
@property (readonly,weak,nonatomic) UITextView *synopsisView;
@property (readonly,weak,nonatomic) UIButton *doneBtn;
@property (readonly,weak,nonatomic) UILabel *headlineLbl;
@property (strong,nonatomic) NSObject<P_StoryItem> *storyItem;
@end

@implementation StoryDumpView

@synthesize storyItem = _storyItem;

@synthesize synopsisView = _synopsisView;
-(UITextView *)synopsisView{
    if(!_synopsisView){
        _synopsisView = [self.view viewWithTag:2];
    }
    return _synopsisView;
}

@synthesize doneBtn = _doneBtn;
-(UIButton *)doneBtn{
    if(!_doneBtn){
        UIView *v = [self getContentSubview];
        _doneBtn = [v viewWithTag:3];
        [_doneBtn addTarget:self action:@selector(doneBtn_pressed_action:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

@synthesize headlineLbl = _headlineLbl;
-(UILabel *)headlineLbl{
    if(!_headlineLbl){
        UIView *v = [self getContentSubview];
        _headlineLbl = [v viewWithTag:4];
    }
    return _headlineLbl;
}

-(instancetype)initWithStoryItem:(NSObject<P_StoryItem> *)storyItem{
    if(self = [self initWithNibName:@"StoryDumpView" bundle:nil]){
        _storyItem = storyItem;
    }
    return self;
}

-(UIView *)getContentSubview{
    return [self.view viewWithTag:1];;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.synopsisView.text = self.storyItem.synopsis;
    self.headlineLbl.text = self.storyItem.headline;
    [self.headlineLbl sizeToFit];
    [self doneBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doneBtn_pressed_action:(UIButton *)sender{
    [ViewHelper popViewFromFront:self];
}


@end
