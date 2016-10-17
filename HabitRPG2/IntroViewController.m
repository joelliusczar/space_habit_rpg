//
//  IntroViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "IntroViewController.h"
#import "CoreDataStackController.h"
#import "Settings.h"
#import "StoryConstants.h"
#import "ZoneDescriptions.h"

@interface IntroViewController ()
@property (nonatomic,weak) BaseViewController *base;
@property (nonatomic,weak) UITextView *introMessage;
@property (nonatomic,weak) UILabel *headline;
@property (nonatomic,weak) UIButton *nextButton;
@property (nonatomic,weak) UISwitch *skipSwitch;
@property (nonatomic,assign) BOOL isThreadAllowed;
@property (nonatomic,assign) BOOL isStoryDone;
@property (nonatomic,assign) BOOL isThreadCurrentlyRunning;
@end

@implementation IntroViewController

@synthesize introMessage = _introMessage;
-(UITextView *)introMessage{
    if(_introMessage == nil){
        _introMessage = [self.view viewWithTag:2];
    }
    return _introMessage;
}

@synthesize headline = _headline;
-(UILabel *)headline{
    if(_headline == nil){
        _headline = [self.view viewWithTag:1];
    }
    return _headline;
}

@synthesize nextButton = _nextButton;
-(UIButton *)nextButton{
    if(_nextButton == nil){
        _nextButton = [self.view viewWithTag:3];
        [_nextButton addTarget:self action:@selector(pressedNext:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextButton;
}

@synthesize skipSwitch = _skipSwitch;
-(UISwitch *)skipSwitch{
    if(_skipSwitch == nil){
        _skipSwitch = [self.view viewWithTag:4];
    }
    return _skipSwitch;
}

-(id)initWithBaseViewController:(BaseViewController *)base{
    if(self = [self initWithNibName:@"IntroViewController" bundle:nil]){
        self.base = base;
        self.isThreadAllowed = YES;
        self.isStoryDone = NO;
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.headline.text = @"";
    self.introMessage.text = @"";
    NSString *headlineText = @"Welcome to Space Habit Frontier";
    [self nextButton];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.isThreadCurrentlyRunning = YES;
        [self autoTypeoutTitle:headlineText characterDelay:.01];
        [self autoTypeIntro:INTRO characterDelay:.01];
        self.isThreadCurrentlyRunning = NO;
    });
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
    
    for(int i = 0;i<title.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headline setText:[NSString stringWithFormat:@"%@%C",self.headline.text,[title characterAtIndex:i]]];
        });
        
        [NSThread sleepForTimeInterval:delay];
    }
}


-(void)autoTypeIntro:(NSString *)text characterDelay:(NSTimeInterval)delay{
    for(int i = 0;i<text.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.introMessage setText:[NSString stringWithFormat:@"%@%C",self.introMessage.text,[text characterAtIndex:i]]];
        });
        [self.introMessage endEditing:YES];
        [NSThread sleepForTimeInterval:delay];
    }
}

-(void)pressedNext:(UIButton *)sender{
    BOOL show = self.skipSwitch.isOn;
    //[self.base setToSkipStory:!show];
    self.isThreadAllowed = NO;
    self.headline.text = [NSString stringWithFormat:@"Welcome to %@",HOME_NAME];
    if(show&&!self.isStoryDone){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                while(self.isThreadCurrentlyRunning);
                dispatch_async(dispatch_get_main_queue(), ^{
                self.introMessage.text = @"";
            });
            self.isThreadAllowed = YES;
            self.isThreadCurrentlyRunning = YES;
            [self autoTypeIntro:HOME_DESCRIPTION characterDelay:.01];
            self.isThreadCurrentlyRunning = NO;
        });
        
    }
    else{
        [self.base dismissIntro];
        
    }
    self.isStoryDone = YES;
    
}





@end
