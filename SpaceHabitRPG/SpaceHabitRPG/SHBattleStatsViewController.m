//
//  SHBattleStatsViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHBattleStatsViewController.h"
@import SHControls;
@import SHModels;

@interface SHBattleStatsViewController ()
@property (weak,nonatomic) IBOutlet SHStatusBar *heroHPBar;
@property (weak,nonatomic) IBOutlet SHStatusBar *monsterHPBar;
@property (weak,nonatomic) IBOutlet SHStatusBar *xpBar;
@property (weak,nonatomic) IBOutlet UILabel *heroDescLbl;
@property (weak,nonatomic) IBOutlet UILabel *monsterDescLbl;
@property (weak,nonatomic) IBOutlet UILabel *xpLbl;
@property (weak,nonatomic) IBOutlet UILabel *lvlLbl;
@property (weak,nonatomic) IBOutlet UILabel *goldLbl;
@end

@implementation SHBattleStatsViewController


-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil{
	if(self = [super initWithNibName:@"SHBattleStatsViewController" bundle:nil]){
		_resourceUtil = resourceUtil;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}


-(void)firstRun{
	NSAssert(self.context,@"You better have that context wired up!");
	SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHHero * hero = [[SHHero alloc] initWithResourceUtil:self.resourceUtil];
	NSInteger currentHP = hero.nowHp;
	NSInteger maxHp = hero.maxHp;
	NSInteger currentXp = hero.nowXp;
	NSInteger maxXp = hero.maxXp;
	NSInteger level = hero.lvl;
	SHMonster *monster = [mm currentMonster];
	NSInteger currentMonsterHP = monster.nowHp;
	NSInteger maxMonsterHP = monster.maxHp;
	NSInteger monsterLvl = monster.lvl;
	NSInteger gold = hero.gold;
	NSString *monsterName = monster.fullName;
	[self updateHeroHP:currentHP whole:maxHp];
	self.goldLbl.text = [NSString stringWithFormat:@"$%ld",gold];
	[self updateHeroXP:currentXp whole:maxXp];
	self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%ld",level];
	[self updateMonsterHP:currentMonsterHP withWhole:maxMonsterHP
		withLvl:monsterLvl withMonsterName:monsterName];
}


-(void)updateHeroHP:(NSInteger)part whole:(NSInteger)whole{
	self.heroDescLbl.text = [NSString stringWithFormat:@"HP:%ld/%ld",part,whole];
	CGFloat hpPercent = ((CGFloat)part) / whole;
	self.heroHPBar.percent = hpPercent;
}


-(void)updateHeroXP:(NSInteger)part whole:(NSInteger)whole{
	self.xpLbl.text = [NSString stringWithFormat:@"XP:%ld/%ld",part,whole];
	CGFloat xpPercent = ((CGFloat)part) / whole;
	self.xpBar.percent = xpPercent;
}


-(void)updateMonsterHP:(NSInteger)part withWhole:(NSInteger)whole withLvl:(NSInteger)lvl
	withMonsterName:(NSString *)monsterName
{
	self.monsterDescLbl.text = [NSString stringWithFormat:@"%@ Lvl:%ld HP:%ld/%ld",
		monsterName, lvl, part, whole];
	CGFloat hpPercent = ((CGFloat)part) / whole;
	self.monsterHPBar.percent = hpPercent;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
