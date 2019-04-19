//
//  SHIntroViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHIntroViewController.h"
#import <SHData/SHCoreDataProtocol.h>
#import <SHModels/SHSettings+CoreDataClass.h>
#import "SHStoryConstants.h"
#import <SHControls/SHFrontEndConstants.h>
#import "SHSectorChoiceViewController.h"
#import <SHModels/SHHero+CoreDataClass.h>
#import <SHModels/SHStoryItemDictionary.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHModels/SHSectorInfoDictionary.h>
#import <SHModels/SHSector_Medium.h>
#import <SHCommon/SHCommonUtils.h>
#import <SHControls/SHSwitch.h>
#import <SHControls/UIView+Helpers.h>
#import "SHControls/UIScrollView+ScrollAdjusters.h"

@interface SHIntroViewController ()
@property (nonatomic,weak) SHCentralViewController *central;
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

@implementation SHIntroViewController


-(UITapGestureRecognizer *)tapper{
  if(!_tapper){
    _tapper = [[UITapGestureRecognizer alloc] initWithTarget:self
      action:@selector(handleTap:)];
    _tapper.numberOfTapsRequired = 1;
  }
  return _tapper;
}

-(UITextView*)introMessageView{
  if(nil == _introMessageView){
    _introMessageView = [[UITextView alloc] init];
    _introMessageView.backgroundColor = [UIColor blackColor];
    _introMessageView.textColor = [UIColor whiteColor];
    SHStoryItemDictionary *storyDict = [SHStoryItemDictionary newWithResourceUtil:self.central.resourceUtil];
    NSString* intro = [storyDict getStoryItem:@"intro"];
    _introMessageView.text = intro;
    CGRect frame = _introMessageView.frame;
    frame.size.width = self.scrollView.frame.size.width;
    _introMessageView.frame = frame;
    _introMessageView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _introMessageView.adjustsFontForContentSizeCategory = YES;
    [_introMessageView sizeToFit];
    CGRect msgFrame = _introMessageView.frame;
    CGFloat diff = shGetParentChildHeightOffset(self.scrollView.frame,msgFrame);
    [_introMessageView translateViewVertically:CGRectGetHeight(msgFrame) + diff];
    _introMessageView.editable = NO;
    _introMessageView.selectable = NO;
  }
  return _introMessageView;
}

-(instancetype)initWithCentralViewController:(SHCentralViewController *)central{
    if(self = [self initWithNibName:@"SHIntroViewController" bundle:nil]){
        _central = central;
        _isThreadAllowed = YES;
        _isStoryDone = NO;
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
  only using this view once, I figure it's alright considering the bug I was
  having to fight with.
  The bug was that frame.width would equal whatever the width of the phone
  you had selected in Interface Builder rather than the width of the phone
  that I was actually simulating.
*/
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  NSString *headlineText = @"Welcome to Space Habit Frontier";
  self.headline.text = @"";
  [self placeIntroMessageView];
  [self.view checkForAndApplyVisualChanges];
  CGFloat scrollLength = self.introMessageView.frame.origin.y;
  SHIntroViewController* __weak weakSelf = self;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
    @autoreleasepool {
      SHIntroViewController* selfRef = weakSelf;
      if(nil == selfRef) return;
      selfRef.isThreadCurrentlyRunning = YES;
      [selfRef autoTypeoutTitle:headlineText characterDelay:SH_CHARACTER_DELAY];
      [selfRef scrollThroughMessage:SH_SCROLL_DELAY scrollLength:scrollLength
        scrollIncrement:SH_SCROLL_INCREMENT];
      selfRef.isThreadCurrentlyRunning = NO;
    }
  });
}


-(void)placeIntroMessageView{
  CGRect msgFrame = self.introMessageView.frame;
  CGFloat diff = shGetParentChildHeightOffset(self.scrollView.frame, msgFrame);
  self.contentHeight.constant += (CGRectGetHeight(self.introMessageView.frame) + diff);
  [self.scrollContent addSubview:self.introMessageView];
  [self.introMessageView addGestureRecognizer:self.tapper];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"


-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
    SHIntroViewController* __weak weakSelf = self;
    for(NSUInteger i = 0;i<title.length&&self.isThreadAllowed;i++){
        dispatch_async(dispatch_get_main_queue(), ^{
          @autoreleasepool {
            SHIntroViewController* selfRef = weakSelf;
            if(nil == selfRef) return;
            [selfRef.headline setText:[NSString stringWithFormat:@"%@%C",selfRef.headline.text,
                                      [title characterAtIndex:i]]];
          }
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
  dispatch_async(dispatch_get_main_queue(),^{
    [self afterScroll];
  });
}


- (IBAction)nextButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  [self.central setToShowStory:YES];
  self.isThreadAllowed = NO;
  self.isStoryDone = YES;
  NSManagedObjectContext *context = [self.central.dataController newBackgroundContext];
  NSObject<SHResourceUtilityProtocol> *resourceUtil = self.central.resourceUtil;
  SHSectorInfoDictionary *zoneInfoDict = [SHSectorInfoDictionary newWithResourceUtil:resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil withInfoDict:zoneInfoDict];
  SHSectorDTO *z = [zm newSpecificSector2:HOME_KEY withLvl:1];
  [self.central afterZonePick:z withContext:context];
}


- (IBAction)skipButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
  if(!self.isStoryDone && self.isThreadCurrentlyRunning){
    self.isStoryDone = YES;
    self.isThreadAllowed = NO;
  }
  [self.central setToShowStory:NO];
  NSManagedObjectContext *context = [self.central.dataController newBackgroundContext];
  NSObject<SHResourceUtilityProtocol> *resourceUtil = self.central.resourceUtil;
  SHSectorInfoDictionary *zoneInfoDict = [SHSectorInfoDictionary newWithResourceUtil:resourceUtil];
  SHSector_Medium *zm = [SHSector_Medium newWithContext:context withResourceUtil:resourceUtil withInfoDict:zoneInfoDict];
  
  SHSectorDTO *z = [zm newSpecificSector2:HOME_KEY withLvl:1];
  [self.central afterZonePick:z withContext:context];
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
  if(!self.isStoryDone && self.isThreadCurrentlyRunning){
    self.isStoryDone = YES;
    self.isThreadAllowed = NO;
    [self.introMessageView resetVerticalOrigin];
    [self afterScroll];
  }
}


-(void)afterScroll{
  _introMessageView.selectable = YES;
}

#pragma clang diagnostic pop

@end
