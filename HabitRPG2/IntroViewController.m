//
//  IntroViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "IntroViewController.h"
#import "P_CoreData.h"
#import "Settings+CoreDataClass.h"
#import "StoryConstants.h"
#import "constants.h"
#import "ZoneChoiceViewController.h"
#import "Hero+CoreDataClass.h"
#import "ViewHelper.h"
#import "SingletonCluster.h"
#import "ZoneInfoDictionary.h"
#import "ZoneHelper.h"
#import "CommonUtilities.h"
#import "CustomSwitch.h"

@interface IntroViewController ()
@property (nonatomic,weak) UIViewController<CentralViewControllerP> *central;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *introMessage;
@property (weak, nonatomic) IBOutlet CustomSwitch *skipSwitch;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (nonatomic,assign) BOOL isThreadAllowed;
@property (nonatomic,assign) BOOL isStoryDone;
@property (nonatomic,assign) BOOL isThreadCurrentlyRunning;
@end

@implementation IntroViewController

@synthesize nextButton = _nextButton;
-(UIButton *)nextButton{
    if(_nextButton!=nil){
        [_nextButton addTarget:self action:@selector(pressedNext:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

-(instancetype)initWithCentralViewController:(UIViewController<CentralViewControllerP> *)central{
    if(self = [self initWithNibName:@"IntroViewController" bundle:nil]){
        self.central = central;
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
    [CommonUtilities checkForAndApplyVisualChanges:self.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        self.isThreadCurrentlyRunning = YES;
        [self autoTypeoutTitle:headlineText characterDelay:CHARACTER_DELAY];
        [self autoTypeIntro:INTRO characterDelay:CHARACTER_DELAY];
        self.isThreadCurrentlyRunning = NO;
    });
    
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
    
    for(NSUInteger i = 0;i<title.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headline setText:[NSString stringWithFormat:@"%@%C",self.headline.text,
                                    [title characterAtIndex:i]]];
        });
        
        [NSThread sleepForTimeInterval:delay];
    }
}


-(void)autoTypeIntro:(NSString *)text characterDelay:(NSTimeInterval)delay{
    for(NSUInteger i = 0;i<text.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.introMessage setText:[NSString stringWithFormat:@"%@%C",self.introMessage.text,
                                        [text characterAtIndex:i]]];
        });
        [NSThread sleepForTimeInterval:delay];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(void)pressedNext:(UIButton *)sender{
    BOOL show = self.skipSwitch.isOn;
    [self.central setToShowStory:show];
    self.isThreadAllowed = NO;
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    self.headline.text = [NSString stringWithFormat:@"Welcome to %@",[zd getZoneName:HOME_KEY]];
    if(show&&!self.isStoryDone){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                while(self.isThreadCurrentlyRunning);
                dispatch_async(dispatch_get_main_queue(), ^{
                self.introMessage.text = @"";
            });
            self.isThreadAllowed = YES;
            self.isThreadCurrentlyRunning = YES;
            [self autoTypeIntro:[zd getZoneDescription:HOME_KEY] characterDelay:CHARACTER_DELAY];
            self.isThreadCurrentlyRunning = NO;
        });
        
    }else if(show){
        [ViewHelper popViewFromFront:self];
        [self.central showZoneChoiceView];
    }
    else{
        [ViewHelper popViewFromFront:self];
        [self.central afterZonePick:nil];
        
    }
    self.isStoryDone = YES;
    
}

#pragma clang diagnostic pop

@end
