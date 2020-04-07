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
#import "SHStoryDumpViewController.h"
#import "SHRateSelectionViewController.h"
#import "SHHabitNameViewController.h"
#import "SHWeeklyActiveDaysViewController.h"
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


static void _SH_setTextViewTheme(UIColor *text, UIColor *textBorder, UIColor *background) {
	UITextView *textViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:@[SHCentralViewController.class]];
	textViewProxy.SH_borderColor = textBorder;
	textViewProxy.SH_borderWidth = 1.0;
	textViewProxy.SH_cornerRadius = 5.0;
	textViewProxy.textColor = text;
	textViewProxy.backgroundColor = background;
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
	UITextView *storyDumpTextViewProxy = [UITextView appearanceWhenContainedInInstancesOfClasses:
		@[SHStoryDumpViewController.class,
			centralCls]];
	storyDumpTextViewProxy.SH_borderColor = background;
}

static void _SH_setBackgroundForUIViewWhenContained(UIColor *background) {
	[UIView appearanceWhenContainedInInstancesOfClasses:@[SHIntroViewController.class]].backgroundColor = background;
	[UIView appearanceWhenContainedInInstancesOfClasses:@[SHHabitViewController.class]].backgroundColor = background;
	[UIView appearanceWhenContainedInInstancesOfClasses:@[SHHabitNameViewController.class]].backgroundColor = background;
	[UIView appearanceWhenContainedInInstancesOfClasses:@[SHWeeklyActiveDaysViewController.class]].backgroundColor = background;
}

static void _SH_setUIButtonProperties(UIColor *disabledText, UIColor *text) {
	[UIButton.appearance setTitleColor:text forState:UIControlStateNormal];
	[UIButton.appearance setTitleColor:disabledText forState:UIControlStateDisabled];
}

static void _SH_setAppearanceBackgrounds(UIColor *background) {
	SHViewController.appearance.viewBackgroundColor = background;
	UITableView.appearance.backgroundColor = background;
	UITabBar.appearance.barTintColor = background;
	SHStatusBar.appearance.backgroundColor = background;
	UIButton.appearance.backgroundColor = background;
	UITextField.appearance.backgroundColor = background;
	UIToolbar.appearance.barTintColor = background;
	UIPickerView.appearance.backgroundColor = background;
	SHSwitch.defaultBackgroundColor = background;
	_SH_setBackgroundForUIViewWhenContained(background);
	_SH_setTextViewBorderSpecialCase(background);
}

+(void)applyDefaultTheme {
	UIColor *background = [UIColor colorNamed:@"background"];
	UIColor *text = [UIColor colorNamed:@"text"];
	UIColor *textBorder = [UIColor colorNamed:@"textBoxBorder"];
	UIColor *transparentBackground = [UIColor colorNamed:@"transparentBackground"];
	UIColor *disabledText = [UIColor colorNamed:@"disabledText"];
	
	_SH_setAppearanceBackgrounds(background);
	UILabel.appearance.textColor = text;
	SHRateSetterView.appearance.textColor = text;

	SHTransparentModalViewController.appearance.viewBackgroundColor = transparentBackground;
	
	_SH_setTextViewTheme(text, textBorder, background);
	_SH_setTextFieldTheme(text, textBorder);
	_SH_setSliderTheme(textBorder);
	_SH_setUIButtonProperties(disabledText, text);
	_SH_setTextViewBorderSpecialCase(background);
	SHSpinPicker.appearance.viewBackgroundColor = transparentBackground;
	SHSpinPicker.appearance.cellTextColor = text;
	SHEditNavigationController.appearance.itemNameViewBackgroundColor = background;
	//SHHabitViewController.appearance.addHabitBtnBackgroundColor = background;
	SHIconBuilder *builder = [[SHIconBuilder alloc] initWithColor:UIColor.grayColor
		withBackgroundColor:background
		withSize:CGSizeMake(50, 50)
		withThickness:10];
	UIImage *check = [builder drawCheck];
	SHSwitch.appearance.onImage = check;
	UIStepper.appearance.tintColor = text;
	
}



@end
