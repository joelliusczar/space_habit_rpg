//
//  SHStoryModeSelectViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/24/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStoryModeSelectViewController.h"

@interface SHStoryModeSelectViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textView;
@end

@implementation SHStoryModeSelectViewController


-(SHStoryPresentationController*)storyCommon{
	if(nil == _storyCommon) {
		_storyCommon = [[SHStoryPresentationController alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
			withViewController:self.prevViewController];
	}
	return _storyCommon;
}


-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil
	withOnIntroCompleteAction:(void (^)(BOOL isStory))onIntroComplete
{
	
	if(self = [super initWithNibName:
		NSStringFromClass(SHStoryModeSelectViewController.class)
		bundle:nil])
	{
		_context = context;
		_resourceUtil = resourceUtil;
		_onIntroComplete = onIntroComplete;
	}
	return self;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	SHStoryItemDictionary *storyDict = [[SHStoryItemDictionary alloc] initWithResourceUtil:self.resourceUtil];
	NSString *storyModeDesc = [storyDict getStoryItem:@"storyModeDesc"];
	self.textView.text = storyModeDesc;
	// Do any additional setup after loading the view from its nib.
}


-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}


-(IBAction)showStory_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	SHSector_Medium *sm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHSector *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
	[s saveToFile];
	SHConfig *config = [[SHConfig alloc] init];
	config.storyMode = SH_STORY_MODE_FULL;
	config.gameState = SH_GAME_STATE_INTRO_FINISHED_INITIAL_STORY;
	
	__weak SHStoryModeSelectViewController *weakSelf = self;
	self.storyCommon.onComplete = ^{
		SHStoryModeSelectViewController *bSelf = weakSelf;
		if(nil == bSelf) return;
		BOOL isStory = YES;
		[bSelf popVCFromFront];
		bSelf.onIntroComplete(isStory);
	};
	[self.storyCommon addSectorTransaction:s];
	[self.storyCommon showSectorStory:s];
}


-(IBAction)skipStory_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	BOOL isStory = NO;
	self.onIntroComplete(isStory);
}



@end
