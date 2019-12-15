//
//  SHBattleStatsViewController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import UIKit;
@import SHCommon;
@import SHControls;

NS_ASSUME_NONNULL_BEGIN

@interface SHBattleStatsViewController : SHViewController
@property (strong, nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtil;
-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;
-(void)firstRun;
-(void)updateHeroHP:(NSInteger)part whole:(NSInteger)whole;
-(void)updateHeroXP:(NSInteger)part whole:(NSInteger)whole;
-(void)updateMonsterHP:(NSInteger)part withWhole:(NSInteger)whole withLvl:(NSInteger)lvl
	withMonsterName:(NSString *)monsterName;
@end

NS_ASSUME_NONNULL_END
