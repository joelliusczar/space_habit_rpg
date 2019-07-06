//
//  SHConfig+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHConfig.h"
#import <SHGlobal/SHConstants.h>
#import <SHCommon/SHCommonUtils.h>


@implementation SHConfig
-(void)setupInitialState{
  self.gameState = SH_GAME_STATE_UNINITIALIZED;
  self.createDateTime = [NSDate date];
  self.dayStartHour = 0;
  self.weekStartDay = 0;
  self.deathGoldPenalty = .25;
  self.heroLvlPenalty = 0;
  self.lastCheckinDateTime = [NSDate date];
  self.permaDeath = NO;
  self.isPasscodeProtected = NO;
  self.reminderHour = 17; //5 o'clock?
  self.storyModeisOn = YES;
  self.sectorLvlPenalty = 1; //0 - no penalty? 1: restart lvl?
  self.allowReport = NO;
  self.userId = nil;
  self.invertColors = NO;
}


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
}


static void copyBetween(NSObject* from,NSObject* to){
  shCopyInstanceVar(from,to,@"createDateTime");
  shCopyInstanceVar(from,to,@"dayStart");
  shCopyInstanceVar(from,to,@"deathGoldPenalty");
  shCopyInstanceVar(from,to,@"heroLvlPenalty");
  shCopyInstanceVar(from,to,@"invertColors");
  shCopyInstanceVar(from,to,@"isPasscodeProtected");
  shCopyInstanceVar(from,to,@"lastCheckinDate");
  shCopyInstanceVar(from,to,@"lastUpdateTime");
  shCopyInstanceVar(from,to,@"permaDeath");
  shCopyInstanceVar(from,to,@"reminderHour");
  shCopyInstanceVar(from,to,@"storyModeisOn");
  shCopyInstanceVar(from,to,@"userId");
  shCopyInstanceVar(from,to,@"sectorLvlPenalty");
}
@end
