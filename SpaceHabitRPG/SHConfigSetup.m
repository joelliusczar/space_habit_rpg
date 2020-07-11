//
//  SHConfigSetup.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHConfigSetup.h"
#import <Foundation/Foundation.h>
@import SHDatetime;
@import SHUtils_C;


int32_t getDayStartHour() {
	int32_t dayStartTime = (int32_t)[NSUserDefaults.standardUserDefaults integerForKey:@"dayStartTime"];
	return dayStartTime;
}


void setDayStartHour(int32_t dayStartTime){
	[NSUserDefaults.standardUserDefaults setInteger:dayStartTime forKey:@"dayStartTime"];
}


int32_t getWeekStartOffset() {
	int32_t weeklyStartDay = (int32_t)[NSUserDefaults.standardUserDefaults integerForKey:@"weeklyStartDay"];
	return weeklyStartDay;
}


void setWeekStartOffset(int32_t weeklyStartDay){
	[NSUserDefaults.standardUserDefaults setInteger:weeklyStartDay forKey:@"weeklyStartDay"];
}


SHGameState getGameState() {
	NSInteger gameState = [NSUserDefaults.standardUserDefaults integerForKey:@"gameState"];
	return (SHGameState)gameState;
}


void setGameState(SHGameState gameState){
	[NSUserDefaults.standardUserDefaults setInteger:gameState forKey:@"gameState"];
}

SHStoryMode getStoryMode() {
	NSInteger storyMode = [NSUserDefaults.standardUserDefaults integerForKey:@"storyMode"];
	return (SHStoryMode)storyMode;
}


void setStoryMode(SHStoryMode storyMode){
	[NSUserDefaults.standardUserDefaults setInteger:storyMode forKey:@"storyMode"];
}


SHStoryState getStoryState() {
	NSInteger storyMode = [NSUserDefaults.standardUserDefaults integerForKey:@"storyState"];
	return (SHStoryState)storyMode;
}


void setStoryState(SHStoryState storyMode){
	[NSUserDefaults.standardUserDefaults setInteger:storyMode forKey:@"storyState"];
}


struct SHDatetime * getLastProcessingDateTime() {
	NSValue *wrapper = (NSValue *)[NSUserDefaults.standardUserDefaults objectForKey:@"lastProcessingDateTime"];
	struct SHDatetime *dt = malloc(sizeof(struct SHDatetime));
	if(!dt) return NULL;
	[wrapper getValue:dt size:sizeof(struct SHDatetime)];
	dt->shifts = NULL; //no telling what this actually points to by now
	dt->currentShiftIdx = SH_NOT_FOUND;
	dt->shiftLen = 0;
	return dt;
}


void setLastProcessingDateTime(struct SHDatetime * lastProcessingDateTime) {
	NSValue *wrapper = [NSValue valueWithBytes:lastProcessingDateTime objCType:@encode(struct SHDatetime)];
	[NSUserDefaults.standardUserDefaults setObject:wrapper forKey:@"lastProcessingDateTime"];
}


bool getIsAppInitialized() {
	bool isAppInitialized = [NSUserDefaults.standardUserDefaults boolForKey:@"isAppInitialized"];
	return isAppInitialized;
}


void setIsAppInitialized(bool isAppInitialized){
	[NSUserDefaults.standardUserDefaults setBool:isAppInitialized forKey:@"isAppInitialized"];
}


void SH_setupConfig(struct SHConfigAccessor *configAccessor) {
	if(!configAccessor) return;
	configAccessor->getDayStartHour = getDayStartHour;
	configAccessor->setDayStartTime = setDayStartHour;
	configAccessor->getWeekStartOffset = getWeekStartOffset;
	configAccessor->setWeekStartOffset = setWeekStartOffset;
	configAccessor->getGameState = getGameState;
	configAccessor->setGameState = setGameState;
	configAccessor->getStoryMode = getStoryMode;
	configAccessor->setStoryMode = setStoryMode;
	configAccessor->getStoryState = getStoryState;
	configAccessor->setStoryState = setStoryState;
	configAccessor->getLastProcessingDateTime = getLastProcessingDateTime;
	configAccessor->setLastProcessingDateTime = setLastProcessingDateTime;
	configAccessor->getIsAppInitialized = getIsAppInitialized;
	configAccessor->setIsAppInitialized = setIsAppInitialized;
}
