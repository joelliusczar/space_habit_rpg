//
//	SHConfig+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHConfig.h"
@import SHGlobal;
@import SHCommon;
@import SHData;

@interface SHConfig ()
@property (strong, nonatomic) NSUserDefaults *userDefaults;
@end

@implementation SHConfig


-(instancetype)init {
	if(self = [super init]) {
		_userDefaults = NSUserDefaults.standardUserDefaults;
	}
	return self;
}

//-(void)setupInitialState{
//	self.gameState = SH_GAME_STATE_UNINITIALIZED;
//	self.createDateTime = [NSDate date];
//	self.dayStartTime = 0;
//	self.weekStartDay = 0;
//	self.deathGoldPenalty = .25;
//	self.heroLvlPenalty = 0;
//	self.lastCheckinDateTime = [NSDate date];
//	self.permaDeath = NO;
//	self.isPasscodeProtected = NO;
//	self.reminderHour = 17; //5 o'clock?
//	self.storyMode = SH_STORY_MODE_FULL;
//	self.sectorLvlPenalty = 1; //0 - no penalty? 1: restart lvl?
//	self.allowReport = NO;
//	self.userId = nil;
//	self.invertColors = NO;
//}


-(NSInteger)dayStartTime {
	NSInteger dayStartTime = [self.userDefaults integerForKey:@"dayStartTime"];
	return dayStartTime;
}


-(void)setDayStartTime:(NSInteger)dayStartTime {
	[self.userDefaults setInteger:dayStartTime forKey:@"dayStartTime"];
}


-(NSInteger)gameState {
	NSInteger gameState = [self.userDefaults integerForKey:@"gameState"];
	return gameState;
}


-(void)setGameState:(NSInteger)gameState {
	[self.userDefaults setInteger:gameState forKey:@"gameState"];
}


-(NSDate*)userTodayStart{
	NSDate *result = [NSDate.date.dayStart timeAfterSeconds:self.dayStartTime];
	return result;
}


-(NSInteger)storyMode {
	NSInteger storyMode = [self.userDefaults integerForKey:@"storyMode"];
	return storyMode;
}


-(void)setStoryMode:(NSInteger)storyMode {
	[self.userDefaults setInteger:storyMode forKey:@"storyMode"];
}



@end
