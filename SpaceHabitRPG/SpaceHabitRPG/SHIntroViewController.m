//
//	SHIntroViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/29/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHIntroViewController.h"
#import "SHStoryConstants.h"
#import "SHSectorChoiceViewController.h"
@import SHCommon;
@import SHControls;


@interface SHIntroViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak,nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak,nonatomic) IBOutlet UIView *scrollContent;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (strong,nonatomic) NSLayoutConstraint *introPositionConstraint;
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
		SHStoryItemDictionary *storyDict = [[SHStoryItemDictionary alloc] initWithResourceUtil:self.resourceUtil];
		NSString* intro = [storyDict getStoryItem:@"intro"];
		_introMessageView.text = intro;
		_introMessageView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_introMessageView.adjustsFontForContentSizeCategory = YES;
		
//		CGRect msgFrame = _introMessageView.frame;
//		CGFloat diff = shGetParentChildHeightOffset(self.scrollView.frame,msgFrame);
//		[_introMessageView translateViewVertically:CGRectGetHeight(msgFrame) + diff];
		_introMessageView.editable = NO;
		_introMessageView.selectable = NO;
		//_introMessageView.hidden = YES;
	}
	return _introMessageView;
}

-(instancetype)initWithSkipAction:(void (^)(void))skipAction
	withOnNextAction:(void (^)(void))onNextAction
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
{
	if(self = [self initWithNibName:@"SHIntroViewController" bundle:nil]){
		_skipAction = skipAction;
		_onNextAction = onNextAction;
		_resourceUtil = resourceUtil;
		_isThreadAllowed = YES;
		_isStoryDone = NO;
	}
	return self;
}


- (void)initialConstrainIntroPosition {
	NSLayoutAnchor *introTop = self.introMessageView.bottomAnchor;
	NSLayoutAnchor *scrollBottom = self.scrollContent.topAnchor;
	self.introPositionConstraint = [introTop constraintEqualToAnchor:scrollBottom];
	self.introPositionConstraint.active = YES;
}


- (void)animateScroll {
	UIViewPropertyAnimator *scrollingAnimation = [[UIViewPropertyAnimator alloc]
																								initWithDuration:5
																								curve:UIViewAnimationCurveLinear
																								animations:^{
		//introPositionConstraint.constant += 50;//self.contentHeight.constant;
		//introPositionConstraint.constant -= self.contentHeight.constant;
		//			self.introToParentConstraint.active = NO;
		//			[self.introMessageView.topAnchor constraintEqualToAnchor:self.scrollContent.topAnchor].active = YES;
		//			self.introToParentConstraint.constant -= self.contentHeight.constant;
		[self.view layoutIfNeeded];
	}];
	[scrollingAnimation startAnimation];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	[self placeIntroMessageView];
	//	[self.view checkForAndApplyVisualChanges];
	
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
	//self.headline.text = @"";
	
	//self.introToParentConstraint.constant -= self.contentHeight.constant;
	
//	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//		@autoreleasepool {
//			self.isThreadCurrentlyRunning = YES;
//			[self autoTypeoutTitle:headlineText characterDelay:SH_CHARACTER_DELAY];
//			[self scrollThroughMessage:SH_SCROLL_DELAY scrollIncrement:SH_SCROLL_INCREMENT];
//			self.isThreadCurrentlyRunning = NO;
//		}
//	});
	[self initialConstrainIntroPosition];
	[self animateScroll];
}


-(void)placeIntroMessageView{
	self.introMessageView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.scrollContent addSubview:self.introMessageView];
	[self.introMessageView addGestureRecognizer:self.tapper];
	[self.introMessageView.widthAnchor constraintEqualToAnchor:self.scrollContent.widthAnchor].active = YES;
	
	self.contentHeight.active = NO;
	[self.scrollContent.heightAnchor
		constraintEqualToAnchor:self.introMessageView.heightAnchor
		multiplier:1].active = YES;
	[self.introMessageView.leadingAnchor constraintEqualToAnchor:self.scrollContent.leadingAnchor].active = YES;
}

-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void)autoTypeoutTitle:(NSString *)title characterDelay:(NSTimeInterval)delay{
	for(NSUInteger i = 0;i < title.length && self.isThreadAllowed;i++){
		dispatch_async(dispatch_get_main_queue(), ^{
			@autoreleasepool { //I don't remember if this autoreleasepool was actually needed
				//I think the pool is needed, each thread needs its own autorelease pool
				[self.headline setText:
					[NSString stringWithFormat:@"%@%C",self.headline.text,
						[title characterAtIndex:i]]];
			}
		});
		
		[NSThread sleepForTimeInterval:delay];
	}
}

-(NSLayoutConstraint*)getTopToBottomConstraint{
	return [self.introMessageView.topAnchor constraintEqualToAnchor:self.scrollContent.bottomAnchor];
}


-(void)scrollThroughMessage:(NSTimeInterval)delay scrollIncrement:(CGFloat)scrollIncrement{
	__block NSLayoutConstraint *topToBottomConstraint = nil;
	__block CGFloat scrollLength = 0;
	dispatch_sync(dispatch_get_main_queue(), ^{
		topToBottomConstraint = [self getTopToBottomConstraint];
		topToBottomConstraint.active = YES;
		self.introMessageView.hidden = NO;
		scrollLength = self.contentHeight.constant;
	});
	while(self.isThreadAllowed && scrollLength > 0){
		scrollLength -= scrollIncrement;
		dispatch_async(dispatch_get_main_queue(), ^{
			topToBottomConstraint.constant -= scrollIncrement;
		});
		[NSThread sleepForTimeInterval:delay];
	}
	dispatch_async(dispatch_get_main_queue(),^{
		[self afterScroll];
	});
}


- (IBAction)nextButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	self.isThreadAllowed = NO;
	self.isStoryDone = YES;
	self.onNextAction();
}


- (IBAction)skipButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	if(!self.isStoryDone && self.isThreadCurrentlyRunning){
		self.isStoryDone = YES;
		self.isThreadAllowed = NO;
	}
	self.skipAction();
}


-(void)handleTap:(UITapGestureRecognizer *)recognizer{
	(void)recognizer;
	if(!self.isStoryDone && self.isThreadCurrentlyRunning){
		self.isStoryDone = YES;
		self.isThreadAllowed = NO;
		#warning fix this to use autolayout constraints
		[self.introMessageView resetVerticalOrigin];
		[self afterScroll];
	}
}


-(void)afterScroll{
	_introMessageView.selectable = YES;
}

@end
