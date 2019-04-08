//
//  Settings+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Settings+CoreDataClass.h"
#import <SHCommon/CommonUtilities.h>

@implementation Settings


-(void)setupInitialState{
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

-(void)copyInto:(NSObject *)object{
  copyProp(self, object, @"objectID");
  copyBetween(self, object);
}

static void copyBetween(NSObject* from,NSObject* to){
  copyProp(from,to,@"createDate");
  copyProp(from,to,@"dayStart");
  copyProp(from,to,@"deathGoldPenalty");
  copyProp(from,to,@"heroLvlPenalty");
  copyProp(from,to,@"invertColors");
  copyProp(from,to,@"isPasscodeProtected");
  copyProp(from,to,@"lastCheckinDate");
  copyProp(from,to,@"lastUpdateTime");
  copyProp(from,to,@"permaDeath");
  copyProp(from,to,@"reminderHour");
  copyProp(from,to,@"storyModeisOn");
  copyProp(from,to,@"userId");
  copyProp(from,to,@"zoneLvlPenalty");
}

@end
