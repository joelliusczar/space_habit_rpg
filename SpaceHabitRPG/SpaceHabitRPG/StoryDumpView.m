//
//  StoryDumpView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "StoryDumpView.h"
#import <SHCommon/ViewHelper.h>

@interface StoryDumpView ()
@property (nonatomic,strong) UITapGestureRecognizer *tapper;
@end

@implementation StoryDumpView

@synthesize storyItem = _storyItem;


-(UITapGestureRecognizer *)tapper{
  if(!_tapper){
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self.synopsisView
                                                      action:@selector(handleTap:)];
    
  }
  return _tapper;
}

-(instancetype)initWithStoryItem:(NSObject<P_StoryItem> *)storyItem{
  if(self = [self initWithNibName:@"StoryDumpView" bundle:nil]){
    _storyItem = storyItem;
  }
  return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *synopsis = nil!=self.storyItem?self.storyItem.synopsis:@"";
    NSString *headline = nil!=self.storyItem?self.storyItem.headline:@"";
    self.synopsisView.text = synopsis;
    self.headlineLbl.text = headline;
    [self.headlineLbl sizeToFit];
    [self doneBtn];
    [self.view addGestureRecognizer:self.tapper];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneBtn_pressed_action:(SHButton *)sender forEvent:(UIEvent *)event {
    popVCFromFront(self);
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
  
}


@end
