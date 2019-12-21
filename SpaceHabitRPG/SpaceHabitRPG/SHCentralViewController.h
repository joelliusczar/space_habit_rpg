//
//	SHCentralViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditNavigationController.h"
#import "SHBattleStatsViewController.h"
@import UIKit;

@import SHModels;

@interface SHCentralViewController : SHViewController;
@property (strong,nonatomic) id<SHDataProviderProtocol> dataController;
@property (strong,nonatomic) SHConfigDTO *configDTO;
@property (strong,nonatomic) SHHeroDTO *heroDTO;
@property (strong,nonatomic) SHMonsterDictionaryEntry *monsterEntry;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
@property (strong,nonatomic) SHEditNavigationController *editController;
@property (strong,nonatomic) SHBattleStatsViewController *battleStats;

+(instancetype)newWithDataController:(NSObject<SHDataProviderProtocol>*)dataController
	andNibName:(NSString*)nib
	andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
	andBundle:(NSBundle*)bundle;

-(instancetype)initWithDataController:(NSObject<SHDataProviderProtocol>*)dataController
	andNibName:(NSString*)nib
	andResourceUtil:(NSObject<SHResourceUtilityProtocol>*)util
	andBundle:(NSBundle*)bundle;
@end
