//
//  SHStoryDumpView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHStoryDumpView.h"
#import <SHControls/UIViewController+Helper.h>

@interface SHStoryDumpView ()
@property (nonatomic,strong) UITapGestureRecognizer *tapper;
@end

@implementation SHStoryDumpView

@synthesize storyItem = _storyItem;


-(UITapGestureRecognizer *)tapper{
  if(!_tapper){
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self.synopsisView
                                                      action:@selector(handleTap:)];
    
  }
  return _tapper;
}


-(UIColor *)backgroundColor{
  return self.view.backgroundColor;
}


-(void)setBackgroundColor:(UIColor *)backgroundColor{
  self.view.backgroundColor = backgroundColor;
}


-(instancetype)initWithStoryItem:(NSObject<SHStoryItemProtocol> *)storyItem{
  if(self = [self initWithNibName:@"SHStoryDumpView" bundle:nil]){
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
    if(self.responseBlock){
      self.responseBlock(self);
    }
    [self popVCFromFront];
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
  
}


@end
