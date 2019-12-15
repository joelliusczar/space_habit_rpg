//
//	SHIntroViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/29/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHIntroViewController.h"
#import "SHSectorChoiceViewController.h"
@import SHCommon;
@import SHControls;


@interface SHIntroViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollContent;
@property (weak, nonatomic) IBOutlet UIView *emptyScrollSegment;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *paddingHeightConstraint;
@property (strong, nonatomic) IBOutlet UITextView *introMessageView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapper;
@property (strong, nonatomic) SHScrollAnimator *animator;
@end

@implementation SHIntroViewController


-(instancetype)initWithOnNextAction:(void (^)(void))onNextAction
	withContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol> *)resourceUtil
{
	if(self = [self initWithNibName:@"SHIntroViewController" bundle:nil]){
		_onNextAction = onNextAction;
		_context = context;
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(SHScrollAnimator*)animator {
	if(nil == _animator) {
		CGFloat scrollTo = [self scrollToYCoord];
		_animator = [[SHScrollAnimator alloc] initWithScrollView:self.scrollView withScrollLength:scrollTo];
		__weak SHIntroViewController *weakSelf = self;
		_animator.onAnimationFinish = ^{
			SHIntroViewController *bSelf = weakSelf;
			if(nil == bSelf) return;
			[bSelf afterScroll];
		};
	}
	return _animator;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	[self.view checkForAndApplyVisualChanges];
	SHStoryItemDictionary *storyDict = [[SHStoryItemDictionary alloc] initWithResourceUtil:self.resourceUtil];
	NSString* introBody = [storyDict getStoryItem:@"introbody"];
	NSString* introPre = [storyDict getStoryItem:@"intropre"];
	NSString* introPost = [storyDict getStoryItem:@"intropost"];
	self.introMessageView.text = [NSString stringWithFormat:@"%@\n%@\n%@",
		introPre,introBody,introPost];
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
	CGRect blankSegmentFrame = self.emptyScrollSegment.frame;
	CGRect textSegementFrame = self.introMessageView.frame;
	CGFloat paddingHeight = shCalcFrameHeightOffset(blankSegmentFrame,textSegementFrame);
	self.paddingHeightConstraint.constant = paddingHeight;
	[self.animator startAnimation];
}


-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(CGFloat)scrollToYCoord {
	CGFloat textHeight = self.introMessageView.bounds.size.height;
	CGFloat scrollBoxHeight = self.scrollView.bounds.size.height;
	CGFloat scrollTo;
	if(textHeight > scrollBoxHeight){
		scrollTo = self.scrollView.contentSize.height - scrollBoxHeight;
	}
	else {
		scrollTo = self.introMessageView.frame.origin.y;
	}
	return scrollTo;
}


- (IBAction)nextButton_press_action:(SHButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	SHConfig *config = [[SHConfig alloc] init];
	if(config.gameState == SH_GAME_STATE_UNINITIALIZED) {
		config.gameState = SH_GAME_STATE_INTRO_FINISHED;
	}
	[self.animator stopAnimation];
	[self popVCFromFront];
	self.onNextAction();
}


-(IBAction)handleTap:(UITapGestureRecognizer *)recognizer{
	(void)recognizer;
	[self.animator stopAnimation];
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
	shouldReceiveTouch:(nonnull UITouch *)touch
{
	(void)gestureRecognizer;
	CGPoint location = [touch locationInView:self.view];
	
	if(CGRectContainsPoint(self.scrollView.frame, location)) {
		return YES;
	}
	return NO;
}

//called at end of animation, so shouldn't need to
//add it anywhere else
-(void)afterScroll{
	self.introMessageView.selectable = YES;
	self.scrollView.userInteractionEnabled = YES;
}

@end
