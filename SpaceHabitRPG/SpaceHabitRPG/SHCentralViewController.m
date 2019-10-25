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
#import "SHSectorChoiceViewController.h"
#import "SHStoryDumpView.h"
#import "SHStoryPresentationIntroController.h"
#import "SHStoryPresentationTypicalController.h"
@import SHGlobal;
@import SHCommon;
@import SHData;
@import SHModels;
@import SHControls;


@import CoreGraphics;

@interface SHCentralViewController ()
@property (strong,nonatomic) UITabBarController *tabsController;
@property (weak,nonatomic) IBOutlet UIView *statsView;
@property (weak,nonatomic) IBOutlet UILabel *heroDescLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *heroHPBar;
@property (weak,nonatomic) IBOutlet UILabel *monsterDescLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *monsterHPBar;
@property (weak,nonatomic) IBOutlet UILabel *xpLbl;
@property (weak,nonatomic) IBOutlet UIProgressView *xpBar;
@property (weak,nonatomic) IBOutlet UILabel *lvlLbl;
@property (weak,nonatomic) IBOutlet UILabel *goldLbl;
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) dispatch_queue_t configAccessorQueue;


@end

@implementation SHCentralViewController



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


-(instancetype)initWithDataController:(NSObject<P_CoreData>*)dataController
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


+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
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
	//most likely any changes you want to add to load should go in
	//determineIfFirstTimeAndSetupConfig
	[self determineIfFirstTimeAndSetupConfig];
}

-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
}

-(void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)setupTabs {
	SHDailyViewController* dc = [[SHDailyViewController alloc] initWithCentral:self];

	self.tabsController.viewControllers = @[dc];
	
	[self.tabsContainer addSubview:self.tabsController.view];
	self.tabsController.view.translatesAutoresizingMaskIntoConstraints = NO;
	[self addChildViewController:self.tabsController];
	[self.tabsController.view.topAnchor constraintEqualToAnchor:self.tabsContainer.topAnchor].active = YES;
	[self.tabsController.view.bottomAnchor constraintEqualToAnchor:self.tabsContainer.bottomAnchor].active = YES;
	[self.tabsController.view.leadingAnchor constraintEqualToAnchor:self.tabsContainer.leadingAnchor].active = YES;
	[self.tabsController.view.trailingAnchor constraintEqualToAnchor:self.tabsContainer.trailingAnchor].active = YES;
}





//#story_logic: both
-(void)prepareScreen{
	NSManagedObjectContext *context = [self.dataController newBackgroundContext];
	self.battleStats = [[SHBattleStatsViewController alloc] initWithContext:context];
	[self pushChildVC:self.battleStats toViewOfParent:self.statsView];
	self.statsView.translatesAutoresizingMaskIntoConstraints = NO;
	self.battleStats.view.translatesAutoresizingMaskIntoConstraints = NO;
	//[self.statsView.heightAnchor constraintEqualToAnchor:self.battleStats.view.heightAnchor].active = YES;
	[self.battleStats.view.topAnchor constraintEqualToAnchor:self.statsView.topAnchor].active = YES;
	[self.battleStats.view.leadingAnchor constraintEqualToAnchor:self.statsView.leadingAnchor].active = YES;
	[self.battleStats.view.trailingAnchor constraintEqualToAnchor:self.statsView.trailingAnchor].active = YES;
	[self.battleStats firstRun];
	[self setupTabs];
}



//#story_logic: both
-(void)determineIfFirstTimeAndSetupConfig{
	[self.context performBlock:^{
		SHConfig_Medium *cm = [[SHConfig_Medium alloc] initWithContext:self.context];
		SHConfig *config = [cm globalConfig];
		if(config.gameState == SH_GAME_STATE_UNINITIALIZED){
			SHStoryPresentationIntroController *introController = [[SHStoryPresentationIntroController alloc]
				initWithContext:self.context
				withViewController:self
				withResourceUtil:self.resourceUtil
				withOnIntroCompleteAction:^{
					[self prepareScreen];
				}];
			[introController startIntro];
		}
		else {
			SHStoryPresentationTypicalController *present = [[SHStoryPresentationTypicalController alloc]
				initWithContext:self.context
				withDataController:self.dataController
				withViewController:self
				withResourceUtil:self.resourceUtil
				withOnPresentComplete:^{
					[self prepareScreen];
				}];
			[present setupNormalSectorAndMonster];
		}
	}];
}


@end
