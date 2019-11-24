//
//  SHPostIntroPresenter.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 11/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHPostIntroPresenter.h"

@implementation SHPostIntroPresenter


-(SHStoryPresentationController*)storyCommon{
	if(nil == _storyCommon) {
		_storyCommon = [[SHStoryPresentationController alloc] initWithContext:self.context
			withResourceUtil:self.resourceUtil
			withViewController:self.viewController];
	}
	return _storyCommon;
}


-(instancetype)initWithContext:(NSManagedObjectContext*)context
	withViewController:(UIViewController*)viewController
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil
	withOnIntroCompleteAction:(void (^)(BOOL isStory))onIntroComplete
{
	if(self = [self init]){
		_context = context;
		_viewController = viewController;
		_resourceUtil = resourceUtil;
		_onIntroComplete = onIntroComplete;
	}
	return self;
}

-(void)runPostIntroSequence{
	UIAlertController *storyAlert = [UIAlertController
		alertControllerWithTitle:@"Play Story Mode?"
		message:@"Do you prefer to use this app with the story elements,"
			"including monster encounters? Or do you prefer to keep the "
			"experience minimal?"
		preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *storyAction = [UIAlertAction
			actionWithTitle:@"Full story mode"
			style:UIAlertActionStyleDefault
			handler:^(UIAlertAction *action){
				(void)action;
				[self onStoryModeSelect];
				
	}];
	UIAlertAction *skipAction = [UIAlertAction
		actionWithTitle:@"Skip story elements"
		style:UIAlertActionStyleDefault
		handler:^(UIAlertAction *action){
			(void)action;
	}];
	[storyAlert addAction:storyAction];
	[storyAlert addAction:skipAction];
	[self.viewController presentViewController:storyAlert animated:YES completion:nil];
}


-(void)onStoryModeSelect {
	SHSector_Medium *sm = [[SHSector_Medium alloc] initWithResourceUtil:self.resourceUtil];
	SHSector *s = [sm newSpecificSector2:HOME_KEY withLvl:1];
	[self.storyCommon showSectorStory:s];
	BOOL isStory = YES;
	self.onIntroComplete(isStory);
}


-(void)onSkipStorySelect {
	BOOL isStory = NO;
	self.onIntroComplete(isStory);
}


@end
