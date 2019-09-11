//
//  SHBattleStatsViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHBattleStatsViewController.h"
#import <SHControls/SHStatusBar.h>
#import <SHModels/SHMonster.h>
#import <SHModels/SHHero.h>
#import <SHModels/SHMonster_Medium.h>
#import <SHModels/SHHero_Medium.h>

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


-(instancetype)initWithContext:(NSManagedObjectContext *)context{
	if(self = [super initWithNibName:@"SHBattleStatsViewController" bundle:nil]){
		_context = context;
	}
	return self;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}


-(void)firstRun{
	NSAssert(self.context,@"You better have that context wired up!");
	[self.context performBlock:^{
		SHMonster_Medium *mm = [[SHMonster_Medium alloc] initWithContext:self.context];
		SHHero_Medium *hm = [[SHHero_Medium alloc] initWithContext:self.context];
		SHHero * hero = [hm hero];
		int32_t currentHP = hero.nowHp;
		int32_t maxHp = hero.maxHp;
		int32_t currentXp = hero.nowXp;
		int32_t maxXp = hero.maxXp;
		int32_t level = hero.lvl;
		SHMonster *monster = [mm currentMonster];
		int32_t currentMonsterHP = monster.nowHp;
		int32_t maxMonsterHP = monster.maxHp;
		int32_t monsterLvl = monster.lvl;
		NSString *monsterKey = monster.monsterKey;
		int32_t gold = hero.gold;
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			[self updateHeroHP:currentHP whole:maxHp];
			self.goldLbl.text = [NSString stringWithFormat:@"$%d",gold];
			[self updateHeroXP:currentXp whole:maxXp];
			self.lvlLbl.text = [NSString stringWithFormat:@"Lv:%d",level];
			[self updateMonsterHP:currentMonsterHP withWhole:maxMonsterHP
				withLvl:monsterLvl withMonsterKey:monsterKey];
		}];
	}];
}


-(void)updateHeroHP:(int)part whole:(int)whole{
	self.heroDescLbl.text = [NSString stringWithFormat:@"HP:%d/%d",part,whole];
	CGFloat hpPercent = ((CGFloat)part) / whole;
	self.heroHPBar.percent = hpPercent;
}


-(void)updateHeroXP:(int)part whole:(int)whole{
	self.xpLbl.text = [NSString stringWithFormat:@"XP:%d/%d",part,whole];
	CGFloat xpPercent = ((CGFloat)part) / whole;
	self.xpBar.percent = xpPercent;
}


#warning rewrite this
-(void)updateMonsterHP:(int32_t)part withWhole:(int32_t)whole withLvl:(int32_t)lvl
	withMonsterKey:(NSString *)monsterKey
{
	NSAssert(SHMonster.monsterInfo,@"We need that monster info set");
	SHMonsterDictionaryEntry *entry = [SHMonster.monsterInfo getMonsterEntry:monsterKey];
	self.monsterDescLbl.text = [NSString stringWithFormat:@"%@ Lvl:%d HP:%d/%d",
		entry.fullName, lvl, part, whole];
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
