//
//  SHSettings+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSettings+CoreDataClass.h"

@implementation SHSettings
-(void)setupInitialState{
  self.gameState = GAME_STATE_UNINITIALIZED;
  self.createDate = [NSDate date];
  self.dayStart = 0;
  self.deathGoldPenalty = .25;
  self.heroLvlPenalty = 0;
  self.lastCheckinDate = [NSDate date];
  self.permaDeath = NO;
  self.isPasscodeProtected = NO;
  self.reminderHour = 17; //5 o'clock?
  self.storyModeisOn = YES;
  self.zoneLvlPenalty = 1; //0 - no penalty? 1: restart lvl?
  self.allowReport = NO;
  self.userId = nil;
}


-(void)copyFrom:(NSObject *)object{
  copyBetween(object, self);
}


static void copyBetween(NSObject* from,NSObject* to){
  copyInstanceVar(from,to,@"createDate");
  copyInstanceVar(from,to,@"dayStart");
  copyInstanceVar(from,to,@"deathGoldPenalty");
  copyInstanceVar(from,to,@"heroLvlPenalty");
  copyInstanceVar(from,to,@"invertColors");
  copyInstanceVar(from,to,@"isPasscodeProtected");
  copyInstanceVar(from,to,@"lastCheckinDate");
  copyInstanceVar(from,to,@"lastUpdateTime");
  copyInstanceVar(from,to,@"permaDeath");
  copyInstanceVar(from,to,@"reminderHour");
  copyInstanceVar(from,to,@"storyModeisOn");
  copyInstanceVar(from,to,@"userId");
  copyInstanceVar(from,to,@"zoneLvlPenalty");
}
@end
