//
//  SHBattleStatsViewController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHCommon/SHResourceUtilityProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHBattleStatsViewController : UIViewController
@property (strong,nonatomic) NSManagedObjectContext *context;
-(instancetype)initWithContext:(NSManagedObjectContext *)context;
-(void)firstRun;
-(void)updateHeroHP:(int)part whole:(int)whole;
-(void)updateHeroXP:(int)part whole:(int)whole;
-(void)updateMonsterHP:(int32_t)part withWhole:(int32_t)whole withLvl:(int32_t)lvl
	withMonsterName:(NSString *)monsterName;
@end

NS_ASSUME_NONNULL_END
