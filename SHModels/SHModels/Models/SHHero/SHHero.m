//
//	SHHero+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHHero.h"

@implementation SHHero
-(NSMutableDictionary *)mapable{
		return [NSMutableDictionary dictionaryWithObjectsAndKeys:
						self.shipName,@"shipName"
						,[NSNumber numberWithInt:self.lvl],@"lvl"
						,[NSNumber numberWithInt:self.maxHp],@"maxHp"
						,[NSNumber numberWithInt:self.nowHp],@"nowHP"
						,[NSNumber numberWithInt:self.maxXp],@"maxXp"
						,[NSNumber numberWithInt:self.nowXp],@"nowXp",nil];
}


-(void)setupInitialState{
	self.gold = 0;
	self.lvl = 1;
	self.maxHp = 50;
	self.maxXp = 100;
	self.nowHp = 50;
	self.nowXp = 0;
	self.shipName = @"";
}
@end
