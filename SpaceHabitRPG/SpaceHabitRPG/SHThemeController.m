//
//  SHThemeController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 1/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHThemeController.h"
#import "SHHabitViewController.h"
#import "SHBattleStatsViewController.h"
#import "SHIntroViewController.h"
#import "SHStoryModeSelectViewController.h"
#import "SHStoryDumpViewController.h"
@import UIKit;
@import SHControls;
@import SHCommon;

@implementation SHThemeController


+(void)applyDarkTheme {
	[self applyDefaultTheme];
}


+(void)applyLightTheme {
	[self applyDefaultTheme];
}


static void _SH_setTextViewTheme(UIColor *text, UIColor *textBorder) {
	UITextView *textViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:@[SHCentralViewController.class]];
	textViewProxy.SH_borderColor = textBorder;
	textViewProxy.SH_borderWidth = 1.0;
	textViewProxy.SH_cornerRadius = 5.0;
	textViewProxy.textColor = text;
}


static void _SH_setTextFieldTheme(UIColor *text, UIColor *textBorder) {
	UITextField.appearance.SH_borderColor = textBorder;
	UITextField.appearance.SH_borderWidth = 1.0;
	UITextField.appearance.SH_cornerRadius = 5.0;
	UITextField.appearance.textColor = text;
}


static void _SH_setSliderTheme(UIColor *textBorder) {
	UISlider.appearance.maximumTrackTintColor = textBorder;
	UISlider.appearance.minimumTrackTintColor = textBorder;
	[UIView appearanceWhenContainedInInstancesOfClasses:@[UISlider.class, SHCentralViewController.class]].backgroundColor = nil;
}


static void _SH_setTextViewBorderSpecialCase(UIColor *background) {
	Class centralCls = SHCentralViewController.class;
	UITextView *introTextViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:
		@[SHIntroViewController.class, centralCls]];
	introTextViewProxy.SH_borderColor = background;
	UITextView *storySelectTextViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:
		@[SHStoryModeSelectViewController.class,
			centralCls]];
	storySelectTextViewProxy.SH_borderColor = background;
	UITextView *storyDumpTextViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:
		@[SHStoryDumpViewController.class,
			centralCls]];
	storyDumpTextViewProxy.SH_borderColor = background;
}

+(void)applyDefaultTheme {
	UIColor *background = [UIColor colorNamed:@"background"];
	UIColor *text = [UIColor colorNamed:@"text"];
	UIColor *textBorder = [UIColor colorNamed:@"textBoxBorder"];
	UILabel.appearance.textColor = text;
	[UIView appearanceWhenContainedInInstancesOfClasses:@[SHCentralViewController.class]].backgroundColor = background;
	UITableView.appearance.backgroundColor = background;
	UITabBar.appearance.barTintColor = background;
	_SH_setTextViewTheme(text, textBorder);
	_SH_setTextFieldTheme(text, textBorder);
	_SH_setSliderTheme(textBorder);
	[UIButton.appearance setTitleColor:text forState:UIControlStateNormal];
	_SH_setTextViewBorderSpecialCase(background);
}



@end
