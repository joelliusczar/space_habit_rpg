//
//	SHCentralViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHEditNavigationController.h"
#import "SHBattleStatsViewController.h"
#import "AppDelegate.h"
@import UIKit;

@import SHModels;

@interface SHCentralViewController : SHViewController;
@property (strong, nonatomic) SHMonsterDictionaryEntry *monsterEntry;
@property (strong, nonatomic) SHBattleStatsViewController *battleStats;
@property (readonly, nonatomic) AppDelegate *appDelegate;


@end
