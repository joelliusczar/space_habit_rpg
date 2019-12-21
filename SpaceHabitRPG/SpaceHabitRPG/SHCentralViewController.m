//
//	SHCentralViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHCentralViewController.h"
#import "SHDailyViewController.h"
#import "SHMenuViewController.h"
#import "SHStoryDumpView.h"
#import "SHStoryPresentationTypicalController.h"
#import "SHIntroViewController.h"
#import "SHStoryModeSelectViewController.h"

@import SHCommon;

@import SHModels;
@import SHControls;
@import CoreGraphics;

@interface SHCentralViewController ()
@property (strong, nonatomic) IBOutlet UIView *tabsContainer;
@property (strong,nonatomic) UITabBarController *tabsController;
@property (weak,nonatomic) IBOutlet UIView *statsView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *listTop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *statsTop;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) dispatch_queue_t configAccessorQueue;
@end

@implementation SHCentralViewController{
	BOOL _shouldShowPostInto;
}


@synthesize tabsController = _tabsController;
-(UITabBarController *)tabsController{
	if(_tabsController == nil){
		_tabsController = [[UITabBarController alloc] init];
	}
	return _tabsController;
}


-(SHEditNavigationController*)editController{
	if(nil == _editController){
		_editController = [[SHEditNavigationController alloc] init];
	}
	return _editController;
}


-(instancetype)initWithDataController:(NSObject<SHDataProviderProtocol>*)dataController
	andNibName:(NSString*)nib
	andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
	andBundle:(NSBundle*)bundle
{
	if(self = [super initWithNibName:nib bundle:bundle]){
		_dataController = dataController;
		_context = [dataController newBackgroundContext];
		_resourceUtil = util;
		_configAccessorQueue = dispatch_queue_create("com.SpaceHabit.Config",DISPATCH_QUEUE_SERIAL);
	}
	return self;
}


+(instancetype)newWithDataController:(NSObject<SHDataProviderProtocol>*)dataController
	andNibName:(NSString*)nib
	andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
	andBundle:(NSBundle*)bundle
{
	id instance = [[SHCentralViewController alloc]
		initWithDataController:dataController
		andNibName:nib
		andResourceUtil:util
		andBundle:bundle];
	return instance;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view checkForAndApplyVisualChanges];
	//most likely any changes you want to add to load
	//should go in determineIfFirstTimeAndSetupConfig
	[self determineIfFirstTimeAndSetupConfig];
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	if(_shouldShowPostInto) {
		[self prepareScreenPostIntro];
	}
}

-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)setupTabs {
	SHDailyViewController* dc = [[SHDailyViewController alloc] initWithCentral:self
		withContext:[self.dataController newBackgroundContext]];

	self.tabsController.viewControllers = @[dc];
	
	[self.tabsContainer addSubview:self.tabsController.view];
	self.tabsController.view.translatesAutoresizingMaskIntoConstraints = NO;
	[self addChildViewController:self.tabsController];
	[self.tabsController.view.topAnchor constraintEqualToAnchor:self.tabsContainer.topAnchor].active = YES;
	[self.tabsController.view.bottomAnchor constraintEqualToAnchor:self.tabsContainer.bottomAnchor].active = YES;
	[self.tabsController.view.leadingAnchor constraintEqualToAnchor:self.tabsContainer.leadingAnchor].active = YES;
	[self.tabsController.view.trailingAnchor constraintEqualToAnchor:self.tabsContainer.trailingAnchor].active = YES;
}


-(void)prepareScreen{
	self.statsView.hidden = NO;
	self.listTop.active = NO;
	self.statsTop.active = YES;
	self.battleStats = [[SHBattleStatsViewController alloc] initWithResourceUtil:self.resourceUtil];
	[self pushChildVC:self.battleStats toViewOfParent:self.statsView];
	self.statsView.translatesAutoresizingMaskIntoConstraints = NO;
	self.battleStats.view.translatesAutoresizingMaskIntoConstraints = NO;
	[self.battleStats.view.topAnchor constraintEqualToAnchor:self.statsView.topAnchor].active = YES;
	[self.battleStats.view.leadingAnchor constraintEqualToAnchor:self.statsView.leadingAnchor].active = YES;
	[self.battleStats.view.trailingAnchor constraintEqualToAnchor:self.statsView.trailingAnchor].active = YES;
	[self.battleStats firstRun];
	[self setupTabs];
}


-(void)prepareScreenPostIntro {
	[self setupTabs];
	__weak SHCentralViewController *weakSelf = self;
	SHStoryModeSelectViewController *storyModeSelect =
		[[SHStoryModeSelectViewController alloc]
		initWithContext:self.context
		withResourceUtil:self.resourceUtil
		withOnIntroCompleteAction:^(BOOL isStory){
			SHCentralViewController *bSelf = weakSelf;
			if(nil == bSelf) return;
			if(isStory) {
				[bSelf prepareScreen];
			}
		}];
	[self arrangeAndPushChildVCToFront:storyModeSelect];
}


- (void)showIntro {
	__weak SHCentralViewController *weakSelf = self;
	SHIntroViewController *introVC = [[SHIntroViewController alloc]
		initWithOnNextAction:^{
		SHCentralViewController *bSelf = weakSelf;
		if(nil == bSelf) return;
		[bSelf prepareScreenPostIntro];
	}
		withContext:self.context
		withResourceUtil:self.resourceUtil];
	[self arrangeAndPushChildVCToFront:introVC];
}


- (void)normalFlow {
	SHStoryPresentationTypicalController *present = [[SHStoryPresentationTypicalController alloc]
		 initWithContext:self.context
		 withViewController:self
		 withResourceUtil:self.resourceUtil
		 withOnPresentComplete:^{
			[self prepareScreen];
	}];
	[present setupNormalSectorAndMonster];
}


-(void)determineIfFirstTimeAndSetupConfig{
	SHConfig *config = [[SHConfig alloc] init];
	if(config.gameState == SH_GAME_STATE_UNINITIALIZED){
		[self showIntro];
	}
	else if(config.gameState == SH_GAME_STATE_INTRO_FINISHED) {
		_shouldShowPostInto = YES;
		//see: viewDidAppear
	}
	else {
		[self normalFlow];
	}
}


@end
