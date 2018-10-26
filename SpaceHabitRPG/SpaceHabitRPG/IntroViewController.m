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
@property (weak, nonatomic) IBOutlet UITextView *introMessageView;
@property (weak, nonatomic) IBOutlet SHButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) UITapGestureRecognizer *tapper;
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


-(UITapGestureRecognizer *)tapper{
  if(!_tapper){
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self.introMessageView
      action:@selector(handleTap:)];
  }
  return _tapper;
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
  self.headline.text = @"";
  self.introMessageView.text = @"";
  NSString *headlineText = @"Welcome to Space Habit Frontier";
  NSString* intro = [SharedGlobal.storyItemDictionary getStoryItem:@"intro"];
  [self nextButton];
  [self.view checkForAndApplyVisualChanges];
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    self.isThreadCurrentlyRunning = YES;
    [self autoTypeoutTitle:headlineText characterDelay:CHARACTER_DELAY];
    [self autoTypeIntro:intro characterDelay:CHARACTER_DELAY];
    self.isThreadCurrentlyRunning = NO;
  });
  
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)autoTypeMessage:(NSString*)text characterDelay:(NSTimeInterval)delay
blockFactory:(wrapReturnVoid (^)(NSString*,NSUInteger))blockFactory{
  for(NSUInteger i = 0;i<text.length&&self.isThreadAllowed;i+=TYPE_INCR_SIZE){
    NSString* segment = i + TYPE_INCR_SIZE < text.length ?
        [text substringWithRange:NSMakeRange(i,TYPE_INCR_SIZE)] :
        [text substringFromIndex:i];
    dispatch_async(dispatch_get_main_queue(), blockFactory(segment,i));
    [NSThread sleepForTimeInterval:delay];
  }
}




#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"


-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
  [self autoTypeMessage:title characterDelay:delay blockFactory:^(NSString* text,NSUInteger idx){
    return ^{
        [self.headline setText:[NSString stringWithFormat:@"%@%@",self.headline.text,text]];
    };
  }];
}


-(void)autoTypeIntro:(NSString *)text characterDelay:(NSTimeInterval)delay{
  [self autoTypeMessage:text characterDelay:delay blockFactory:^(NSString* text,NSUInteger idx){
    return ^{
      
      [self.introMessageView setText:[NSString stringWithFormat:@"%@%@",self.introMessageView.text,
        text]];
      [self.introMessageView setNeedsDisplay];
      CGFloat contentHeight = self.introMessageView.contentSize.height;
      if(contentHeight > (self.introMessageView.frame.size.height*.5)){
        [self.introMessageView scrollByOffset:25];
      }
    };
  }];
}


-(void)pressedNext:(UIButton *)sender{
    [self.central setToShowStory:YES];
    self.isThreadAllowed = NO;
    ZoneInfoDictionary *zd = [SingletonCluster getSharedInstance].zoneInfoDictionary;
    self.headline.text = [NSString stringWithFormat:@"Welcome to %@",[zd getZoneName:HOME_KEY]];
    if(!self.isStoryDone){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                while(self.isThreadCurrentlyRunning);
                dispatch_async(dispatch_get_main_queue(), ^{
                self.introMessageView.text = @"";
            });
            self.isThreadAllowed = YES;
            self.isThreadCurrentlyRunning = YES;
            [self autoTypeIntro:[zd getZoneDescription:HOME_KEY] characterDelay:CHARACTER_DELAY];
            self.isThreadCurrentlyRunning = NO;
        });
        
    }else{
        popVCFromFront(self);
        [self.central showZoneChoiceView];
    }
    self.isStoryDone = YES;
    
}

-(void)handleTap:(UITapGestureRecognizer *)recognizer{
  if(!self.isStoryDone && self.isThreadCurrentlyRunning){
    self.isThreadCurrentlyRunning = NO;
    self.isStoryDone = YES;
  }
}

#pragma clang diagnostic pop

@end
