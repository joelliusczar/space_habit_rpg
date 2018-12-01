//
//  IntroViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "IntroViewController.h"
#import <SHData/P_CoreData.h>
#import <SHModels/Settings+CoreDataClass.h>
#import "StoryConstants.h"
#import <SHGlobal/Constants.h>
#import "ZoneChoiceViewController.h"
#import <SHModels/Hero+CoreDataClass.h>
#import <SHCommon/ViewHelper.h>
#import <SHModels/SingletonCluster+Entity.h>
#import <SHModels/ZoneInfoDictionary.h>
#import <SHModels/Zone+Helper.h>
#import <SHCommon/CommonUtilities.h>
#import <SHControls/SHSwitch.h>
#import <SHCommon/UIView+Helpers.h>
#import "SHControls/UIScrollView+ScrollAdjusters.h"

@interface IntroViewController ()
@property (nonatomic,weak) UIViewController<P_CentralViewController> *central;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic) IBOutlet UIView *scrollContent;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (strong, nonatomic) UITextView *introMessageView;
@property (weak, nonatomic) IBOutlet SHButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) UITapGestureRecognizer *tapper;
@property (nonatomic,assign) BOOL isThreadAllowed;
@property (nonatomic,assign) BOOL isStoryDone;
@property (nonatomic,assign) BOOL isThreadCurrentlyRunning;
@end

@implementation IntroViewController


-(UITapGestureRecognizer *)tapper{
  if(!_tapper){
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self.introMessageView
      action:@selector(handleTap:)];
  }
  return _tapper;
}

-(UITextView*)introMessageView{
  if(!_introMessageView){
    _introMessageView = [[UITextView alloc] init];
    _introMessageView.backgroundColor = [UIColor blackColor];
    _introMessageView.textColor = [UIColor whiteColor];
    NSString* intro = [SharedGlobal.storyItemDictionary getStoryItem:@"intro"];
    _introMessageView.text = intro;
    CGRect frame = _introMessageView.frame;
    frame.size.width = self.scrollView.frame.size.width;
    _introMessageView.frame = frame;
    _introMessageView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _introMessageView.adjustsFontForContentSizeCategory = YES;
    [_introMessageView sizeToFit];
    CGRect msgFrame = _introMessageView.frame;
    CGFloat diff = getParentChildHeightOffset(self.scrollView.frame,msgFrame);
    msgFrame.origin.y += CGRectGetHeight(msgFrame) + diff;
    _introMessageView.frame = msgFrame;
  }
  return _introMessageView;
}

-(instancetype)initWithCentralViewController:(UIViewController<P_CentralViewController> *)central{
    if(self = [self initWithNibName:@"IntroViewController" bundle:nil]){
        self.central = central;
        self.isThreadAllowed = YES;
        self.isStoryDone = NO;
    }
    return self;
}


-(void)viewDidLoad {
  [super viewDidLoad];
}


/*
  Because of a bug with XCode (or ObjC) and some of the widths not getting
  set until viewDidAppear.
  Normally, this is probably a bad place to put this stuff, but since I',
  only using this view once, I figure it's alright.
*/
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  NSString *headlineText = @"Welcome to Space Habit Frontier";
  self.headline.text = @"";
  [self placeIntroMessageView];
  [self.view checkForAndApplyVisualChanges];
  CGFloat scrollLength = self.introMessageView.frame.origin.y;
  CGFloat scrollIncrement = 1;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    self.isThreadCurrentlyRunning = YES;
    [self autoTypeoutTitle:headlineText characterDelay:CHARACTER_DELAY];
    [self scrollThroughMessage:CHARACTER_DELAY scrollLength:scrollLength
      scrollIncrement:scrollIncrement];
    self.isThreadCurrentlyRunning = NO;
  });
}


-(void)placeIntroMessageView{
  CGRect msgFrame = self.introMessageView.frame;
  CGFloat diff = getParentChildHeightOffset(self.scrollView.frame, msgFrame);
  self.contentHeight.constant += (CGRectGetHeight(self.introMessageView.frame) + diff);
  [self.scrollContent addSubview:self.introMessageView];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"


-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
  
    for(NSUInteger i = 0;i<title.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.headline setText:[NSString stringWithFormat:@"%@%C",self.headline.text,
              [title characterAtIndex:i]]];
        });
      
        [NSThread sleepForTimeInterval:delay];
    }
}


-(void)scrollThroughMessage:(NSTimeInterval)delay scrollLength:(CGFloat)scrollLength
scrollIncrement:(CGFloat)scrollIncrement{
  while(self.isThreadAllowed && scrollLength > 0){
    scrollLength -= scrollIncrement;
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.introMessageView translateViewVertically:-scrollIncrement];
    });
    [NSThread sleepForTimeInterval:delay];
  }
}


- (IBAction)nextButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  [self.central setToShowStory:YES];
    self.isThreadAllowed = NO;
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    self.headline.text = [NSString stringWithFormat:@"Welcome to %@",[zd getZoneName:HOME_KEY]];
    if(!self.isStoryDone){
        //[self autoTypeIntro:[zd getZoneDescription:HOME_KEY] characterDelay:CHARACTER_DELAY];
    }else{
        popVCFromFront(self);
        [self.central showZoneChoiceView];
    }
    self.isStoryDone = YES;

}


- (IBAction)skipButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
  if(!self.isStoryDone && self.isThreadCurrentlyRunning){
    self.isThreadCurrentlyRunning = NO;
    self.isStoryDone = YES;
  }
}

#pragma clang diagnostic pop

@end
