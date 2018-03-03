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
@end

@implementation StoryDumpView

@synthesize storyItem = _storyItem;


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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneBtn_pressed_action:(SHButton *)sender forEvent:(UIEvent *)event {
    popVCFromFront(self);
}


@end
